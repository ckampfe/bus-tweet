require APP_ROOT.join('app', 'models', 'transit')
require APP_ROOT.join('app', 'models', 'matcher')

class Prediction # CURRENTLY NOT INHERITING FROM AR::BASE

  ### class ###

  def self.resource
    'getpredictions'
  end

  extend TransitHelpers
  extend Matcher

  ### instance ###
  attr_reader :data, :system_time, :stop
  def initialize(name_query, num_of_preds="4")
    @stop = Matcher.closest(name_query)

    @data = prettify(Prediction.get([{ :key => 'stpid', :val => stop[:number] },
                                     { :key => 'top', :val => num_of_preds }])['bustime_response']['prd'])
    @system_time = SystemTime.get['bustime_response']['tm']
  end

  private
  def prettify(ugly) # the CTA naming conventions are bad; make them nicer
    unless ugly.is_a? Array # wrap in array if not already
      ugly = [ugly]
    end

    # I only care about arrivals, so ignore departures
    ugly.select { |pred| pred['typ'] == 'A' }.
    map do |pred|
      { :type => 'arrival',
        :name => pred['stpnm'],
        :stop_id => pred['stpid'], # in DB for Stop is 'number', but this is Prediction
        :route_number => pred['rt'],
        :direction => pred['rtdir'],
        :destination => pred['des'],
        :timestamp => pred['tmstmp'],
        :arrival_time => pred['prdtm'] }
    end
  end
end
