module TransitHelpers
  BASE_URL = 'http://www.ctabustracker.com/bustime/api/v1/'

  def get(opts={})
    query_param = opts[:query_param] || false
    value       = opts[:value] || false

    if query_param && value
      url = BASE_URL + self.resource + '?' + 'key=' + CTA_KEY + '&' + query_param + '=' + value
      puts url
    else
      url = BASE_URL + self.resource + '?' + 'key=' + CTA_KEY
    end

    Hash.from_xml(open(url))
  end
end
