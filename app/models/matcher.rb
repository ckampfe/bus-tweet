require APP_ROOT.join('app', 'models', 'stop')

module Matcher
  STOPS = Stop.all

  def self.closest(query)
    FuzzyMatch.engine = :amatch # C extensions
    FuzzyMatch.new(STOPS, :read => :name).find(query)
  end
end
