require_relative 'test_helper'

class CLITest < Minitest::Test
  def test_displays_help_if_no_argument_provided
    help_msg = <<-EOS
          Usage:
            mako [subcommand] [path...]

          Subcommands:
            new       Create a new Mako scaffold in PATH.  If no PATH provided, defaults to current directory.
            build     Build your Mako site.
            version   Display the version
    EOS
    assert_output(help_msg) { Mako::CLI.start([]) }
  end

  def test_displays_help_if_unknown_command_is_provided
    help_msg = <<-EOS
          Usage:
            mako [subcommand] [path...]

          Subcommands:
            new       Create a new Mako scaffold in PATH.  If no PATH provided, defaults to current directory.
            build     Build your Mako site.
            version   Display the version
    EOS
    assert_output(help_msg) { Mako::CLI.start(['unknown']) }
  end
end
