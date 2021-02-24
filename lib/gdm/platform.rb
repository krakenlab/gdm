# frozen_string_literal: true
require 'uname'

module GDM
  def windows?
    Gem.win_platform? || Uname.invokeUname('-a').include?("Microsoft")
  end

  def linux?
    !windows? && RUBY_PLATFORM.include?('linux')
  end

  def osx?
    raise 'Must be implemented :)'
  end
end