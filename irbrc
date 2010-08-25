# Some default enhancements/settings for IRB, based on
# http://wiki.rubygarden.org/Ruby/page/show/Irb/TipsAndTricks

unless defined? ETC_IRBRC_LOADED

  # Require RubyGems by default.
  require 'rubygems'
  
  # Activate auto-completion.
  require 'irb/completion'
  
  # Use the simple prompt if possible.
  IRB.conf[:PROMPT_MODE] = :SIMPLE if IRB.conf[:PROMPT_MODE] == :DEFAULT
  
  # Wirble (gem install wirble)
  begin
    require 'wirble'
    Wirble.init
    Wirble.colorize
  rescue LoadError
  end
     
  # Setup permanent history.
  HISTFILE = "~/.irb_history"
  MAXHISTSIZE = 100
  begin
    histfile = File::expand_path(HISTFILE)
    if File::exists?(histfile)
      lines = IO::readlines(histfile).collect { |line| line.chomp }
      puts "Read #{lines.nitems} saved history commands from '#{histfile}'." if $VERBOSE
      Readline::HISTORY.push(*lines)
    else
      puts "History file '#{histfile}' was empty or non-existant." if $VERBOSE
    end
    Kernel::at_exit do
      lines = Readline::HISTORY.to_a.reverse.uniq.reverse
      lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.nitems > MAXHISTSIZE
      puts "Saving #{lines.length} history lines to '#{histfile}'." if $VERBOSE
      File::open(histfile, File::WRONLY|File::CREAT|File::TRUNC) { |io| io.puts lines.join("\n") }
    end
  rescue => e
    puts "Error when configuring permanent history: #{e}" if $VERBOSE
  end

  # http://ozmm.org/posts/time_in_irb.html
  def time(times = 1)
    require 'benchmark'
    ret = nil
    Benchmark.bm { |x| x.report { times.times { ret = yield } } }
    ret
  end

  # http://github.com/rtomayko/dotfiles/blob/rtomayko/.irbrc
  # list object methods
  def local_methods(obj=self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  def ls(obj=self)
    width = `stty size 2>/dev/null`.split(/\s+/, 2).last.to_i
    width = 80 if width == 0
    local_methods(obj).each_slice(3) do |meths|
      pattern = "%-#{width / 3}s" * meths.length
      puts pattern % meths
    end
  end

  # Just for Rails
  if ENV['RAILS_ENV']
    IRB.conf[:IRB_RC] = Proc.new do
      Rails.logger.flush
      Rails.logger.instance_variable_set("@log", STDOUT)
      Rails.logger.auto_flushing = 1
    end
  end
  ETC_IRBRC_LOADED=true
end
