require 'rake'
require "sinatra/activerecord/rake"
require 'rspec/core/rake_task'

require ::File.expand_path('../config/environment', __FILE__)


desc "Start pry with app environment loaded"
task "console" do
  exec "pry -r ./config/environment"
end

namespace :get do
  desc "get CTA routes"
  task :routes do
    ### get ###
    routes = Route.get['bustime_response']['route']

    ### make pretty ###
    nice_routes = routes.map do |route|
      { :number => route['rt'], :name => route['rtnm'] }
    end

    ### db ###
    nice_routes.each do |route|
      Route.create!(:name => route[:name], :number => route[:number])
    end
  end

  desc "get directions for CTA routes"
  task :directions do
    routes = Route.all
    routes.each do |route|
      ### get ###
      directions = Direction.get(:query_param => 'rt', :value => route[:number])

      ### make pretty ###
      directions = ['bustime_response']['dir']
      # conditionally assign if single result
      directions = [directions] if directions.class == String

      ### db ###
      directions.each do |direction|
        route.directions << Direction.find_or_create_by(:name => direction)
      end
    end
  end
end
