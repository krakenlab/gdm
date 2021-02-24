# frozen_string_literal: true

require 'fileutils'

module GDM
  module Workspace
    GODOT_WORKSPACE = File.expand_path('~/.gdm/godot')
    GODOT_SERVER_WORKSPACE = File.expand_path('~/.gdm/server')
    GODOT_HEADLESS_WORKSPACE = File.expand_path('~/.gdm/headless')

    module_function

    def create
      ::FileUtils.mkdir_p GODOT_WORKSPACE
      ::FileUtils.mkdir_p GODOT_SERVER_WORKSPACE
      ::FileUtils.mkdir_p GODOT_HEADLESS_WORKSPACE
    end
  end
end