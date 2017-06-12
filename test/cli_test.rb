# frozen_string_literal: true

require_relative 'test_helper'

class CLITest < Minitest::Test
  def setup
    @help_msg = <<~EOS
      Usage:
        mako [subcommand] [path...]

      Subcommands:
        new       Create a new Mako scaffold in PATH.  If no PATH provided, defaults to current directory.
        build     Build your Mako site. Default: only build HTML.
        schedule  Schedule Mako to build according to your schedule.rb file.
        version   Display the version.

      Options:
        --with-sass  When supplied to build, also generates CSS from SCSS files.
    EOS
  end

  def test_displays_help_if_no_argument_provided
    out, _err = capture_io do
      Mako::CLI.start([])
    end

    assert_match out, @help_msg
  end

  def test_displays_help_if_unknown_command_is_provided
    out, _err = capture_io do
      Mako::CLI.start(['unknown'])
    end

    assert_match out, @help_msg
  end
end
