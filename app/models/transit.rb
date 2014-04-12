module TransitHelpers
  BASE_URL = 'http://www.ctabustracker.com/bustime/api/v1/'

  def get(params=[])
    # example:
    # [{ :key => 'rt', :val => '20' },
    #  { :key => 'dir', :val => "East Bound" }]

    if params
      url = BASE_URL + self.resource + '?' + 'key=' + CTA_KEY + '&' + urlize(params)
    else
      url = BASE_URL + self.resource + '?' + 'key=' + CTA_KEY
    end

    Hash.from_xml(open(url)) # CTA endpoints return XML
  end

  private
  # heavily inspired by the Twitter gem:
  # https://github.com/sferik/twitter/blob/master/lib/twitter/streaming/client.rb#L119
  def urlize(params)
    params.map do |pair|
      [pair[:key], URI.encode(pair[:val])].join('=')
    end.join('&')
  end
end
