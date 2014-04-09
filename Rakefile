require 'rake'
require "sinatra/activerecord/rake"
require 'rspec/core/rake_task'

require ::File.expand_path('../config/environment', __FILE__)


desc "Start pry with app environment loaded"
task "console" do
  exec "pry -r ./config/environment"
end

desc "get CTA routes"
task "get:routes" do
  # get routes from CTA
  routes = Route.get['bustime_response']['route']

  # make nice
  nice_routes = routes.map do |route|
    { :number => route['rt'], :name => route['rtnm'] }
  end

  nice_routes.each do |route|
    Route.create!(:name => route[:name], :number => route[:number])
  end
end

desc "get directions for CTA routes"
task "get:directions" do
  routes = Route.all
  routes.each do |route|
    # for each route, get directions
    directions = Direction.get(:query_param => 'rt', :value => route[:number])['bustime_response']['dir']

    # conditionally assign if single result
    directions = [directions] if directions.class == String

    # add directions to db or find them, and associate with routes
    directions.each do |direction|
      route.directions << Direction.find_or_create_by(:name => direction)
    end
  end
end
