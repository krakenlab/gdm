# frozen_string_literal: true
require 'uname'

module GDM
  module Platform
    module_function

    def windows_editor_filename
      "#{::GDM::Workspace::GODOT_WORKSPACE}/#{::GDM::GODOT}.exe"
    end

    def linux_editor_filename
      "#{::GDM::Workspace::GODOT_WORKSPACE}/#{::GDM::GODOT}.o"
    end

    def linux_server_filename
      "#{::GDM::Workspace::GODOT_SERVER_WORKSPACE}/#{::GDM::GODOT}.o"
    end

    def linux_headless_filename
      "#{::GDM::Workspace::GODOT_HEADLESS_WORKSPACE}/#{::GDM::GODOT}.o"
    end

    def windows?
      Gem.win_platform? || Uname.invokeUname('-a').include?('Microsoft')
    end

    def linux?
      !windows? && RUBY_PLATFORM.include?('linux')
    end

    def osx?
      raise 'Must be implemented :)'
    end
  end
end