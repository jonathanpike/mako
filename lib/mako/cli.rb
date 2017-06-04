require_relative 'commands/build'
require_relative 'commands/new'
require_relative 'commands/version'

module Mako
  class CLI
    COMMANDS = %w(build new version)

    # Takes ARGV and parses the first element (command) to see if it is
    # in the commands array.  If not, display help.
    #
    # @param [Array] argv
    def self.start(argv)
      command = argv.shift
      if COMMANDS.include? command
        CLI.invoke(command, argv)
      else
        help = <<-EOS
          Usage:
            mako [subcommand] [path...]

          Subcommands:
            new       Create a new Mako scaffold in PATH.  If no PATH provided, defaults to current directory.
            build     Build your Mako site.
            version   Display the version
        EOS
        puts help
      end
    end

    # Calls #perform on the provided command class. When the command is done
    # running, print out any errors that the command had.
    #
    # @param [String] command
    # @param [Array] args the remainder of the ARGV arguments
    def self.invoke(command, args = [])
      Object.const_get("Mako::#{command.capitalize}").perform(args)
      if Mako.errors.any?
        Mako.errors.messages.each do |error_msg|
          Mako.logger.warn error_msg
        end
      end
    end
  end
end
