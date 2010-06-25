#!/usr/bin/env ruby

%w(rubygems ruby_app_config yaml ap).each  { |lib| require lib}

config = AppConfig.create("application.yml")
ap config
puts ""

config = AppConfig.create("application.yml", :environment => 'development')
ap config
puts ">> "+config.foo.key
puts ""

config = AppConfig.create("application.yml", :environment => 'production')
ap config
puts ">> "+config.foo.key
puts ""
