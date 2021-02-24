# frozen_string_literal: true

require 'net/http'
require 'thread'
require 'zip'

module GDM
  module Repo
    LIBRARY = {
      '3.2.3' => {
        linux: 'https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_x11.64.zip',
        osx: 'https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_osx.64.zip',
        windows: 'https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_win64.exe.zip',
        server: 'https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_linux_server.64.zip',
        headless: 'https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_linux_headless.64.zip',
        template: 'https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_export_templates.tpz',
      }
    }

    CURRENT = LIBRARY[::GDM::GODOT]
  end

  module Editor

    module_function

    def windows_install
      filename = ::GDM::Platform.windows_editor_filename
      url = ::GDM::Repo::CURRENT[:windows]
      donwload(filename, url)
    end

    def linux_install
      t1 = Thread.new do
        filename = ::GDM::Platform.linux_editor_filename
        url = ::GDM::Repo::CURRENT[:linux]
        donwload(filename, url)
      end

      t2 = Thread.new do
        filename = ::GDM::Platform.linux_server_filename
        url = ::GDM::Repo::CURRENT[:server]
        donwload(filename, url)
      end

      t3 = Thread.new do
        filename = ::GDM::Platform.linux_headless_filename
        url = ::GDM::Repo::CURRENT[:headless]
        donwload(filename, url)
      end

      [t1, t2, t3].map(&:join)
    end

    def donwload(filename, url, ext = 'zip')
      filename_ext = "#{filename}.#{ext}"
      puts "downloading #{filename_ext}"

      ::File.open(filename_ext, 'wb') do |file|
        file.write(Net::HTTP.get(URI(url)))
      end unless File.exists?(filename_ext)

      puts "#{filename_ext} downloaded"

      unzip(filename_ext, filename)
    end

    def unzip(zipname, filename)
      ::Zip::File.open(zipname).each do |file|
        file.extract(filename) unless File.exists?(filename)
      end
    
      File.chmod(0777, filename) if ::GDM::Platform.linux?

      puts("#{filename} unziped")
    end

    def install
      windows_install if ::GDM::Platform.windows?
      linux_install if ::GDM::Platform.linux?
    end
  end
end
