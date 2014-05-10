Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

get '/start' do

  puts "starting..."

  Tweet.stream do |query_tweet|
    response = ""

    begin
      prediction = Prediction.new(query_tweet[:text])
      response = Packaging.pack(prediction.data, prediction.system_time)
    rescue => e
      response = e.to_s
    ensure
      Tweet.reply("@" + query_tweet[:screen_name] + " " + response)
    end
  end
end
