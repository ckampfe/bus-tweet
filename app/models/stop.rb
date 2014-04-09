require APP_ROOT.join('app', 'models', 'transit')

class Stop < ActiveRecord::Base
  has_many :route_stops
  has_many :routes, :through => :route_stops

  def self.resource
    'getstops'
  end

  extend TransitHelpers
end
