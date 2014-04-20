Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

Tweet.stream do |query_tweet|
  # tweet contains :screen_name and :text
  puts "tweet, pre prediction: #{query_tweet}"
  response = ""

  begin
    prediction = Prediction.new(query_tweet[:text])
    response = Packaging.pack(prediction.data, prediction.system_time)
  rescue => e
    response = e.to_s
  ensure
    puts "pred:"
    puts response
    Tweet.reply("@" + query_tweet[:screen_name] + " " + response)
  end
end
