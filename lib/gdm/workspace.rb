# frozen_string_literal: true

module GDM
  GODOT_WORKSPACE = File.expand_path('~/.gdm/godot')
  GODOT_SERVER_WORKSPACE = File.expand_path('~/.gdm/server')
  GODOT_HEADLESS_WORKSPACE = File.expand_path('~/.gdm/headless')

  def create_workspace
    FileUtils.mkdir_p GDM::GODOT_WORKSPACE
    FileUtils.mkdir_p GDM::GODOT_SERVER_WORKSPACE
    FileUtils.mkdir_p GDM::GODOT_HEADLESS_WORKSPACE
  end

  module_function create_workspace
end