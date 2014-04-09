require APP_ROOT.join('app', 'models', 'transit')

class Route < ActiveRecord::Base
  has_many :route_directions
  has_many :directions, :through => :route_directions

  has_many :route_stops
  has_many :stops, :through => :route_stops

  def self.resource
    'getroutes'
  end

  extend TransitHelpers
end
