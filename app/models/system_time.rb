class SystemTime < ActiveRecord::Base
  def self.resource
    'gettime'
  end

  extend TransitHelpers
end
