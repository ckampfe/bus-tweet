require APP_ROOT.join('app', 'models', 'transit')

class Direction < ActiveRecord::Base
  has_many :route_directions
  has_many :routes, :through => :route_directions

  def self.resource
    'getdirections'
  end

  extend TransitHelpers
end
