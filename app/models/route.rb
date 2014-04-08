class Route < ActiveRecord::Base
  has_many :route_directions
  has_many :route_stops

  CTA_API_KEY = ENV['CTA_API_KEY']

  def self.get
  end
end
