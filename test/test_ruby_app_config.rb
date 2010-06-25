require 'helper'
class AppConfigTest < Test::Unit::TestCase
  TEST_FILE = File.join(File.dirname(__FILE__),"fixtures","sample.yml")

  def test_method_accessor_for_top_level_attributes
    config = AppConfig.create(TEST_FILE)
    assert_equal "AwesomeApp", config.application
  end

  def test_read_a_scoped_attribute
    config = AppConfig.create(TEST_FILE, :environment => 'development')
    assert_equal "development_bar", config.foo.key
  end

  def test_attributes_are_inherited
    config = AppConfig.create(TEST_FILE, :environment => 'production')
    assert_equal "bar", config.foo.key
  end

  def test_deep_attributes_are_merged
    config = AppConfig.create(TEST_FILE, :environment => 'development')
    assert_equal "still_here", config.foo.deep_merge
  end

  def test_erb_rendering
    config = AppConfig.create(TEST_FILE)
    assert_equal 'VERSION', config.version
  end
end
