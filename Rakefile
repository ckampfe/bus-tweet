require 'rake'
require "sinatra/activerecord/rake"
require 'rspec/core/rake_task'

require ::File.expand_path('../config/environment', __FILE__)


desc "Start pry with app environment loaded"
task "console" do
  exec "pry -r ./config/environment"
end

