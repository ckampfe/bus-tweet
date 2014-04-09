class Tweet
  def self.stream
    puts "streaming..."

    T.user(:replies => 'all') do |obj|
      puts obj
      if obj.is_a? Twitter::Tweet
      # puts obj.text if obj.is_a?(Twitter::Tweet)
        # obj.user_mentions.each do |mention|
        #   puts mention.screen_name
        # end

        sn_mentions = obj.user_mentions.map do |mention|
          mention.screen_name
        end

        puts sn_mentions.inspect

        if sn_mentions.include? "kilophoton"
          puts "KILOPHOTON MENTION"
          puts obj.text
        end
      end
    end
  end


  private
  def mention?(tweet)
    tweet.in_reply_to_screen_name == 'kilophoton'
  end
end
