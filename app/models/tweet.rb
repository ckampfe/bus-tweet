class Tweet
  def self.stream
    puts "streaming..."

    T.user(:replies => 'all') do |obj|
      puts obj
      if obj.is_a? Twitter::Tweet
        tweet = obj
      # puts obj.text if obj.is_a?(Twitter::Tweet)
        # obj.user_mentions.each do |mention|
        #   puts mention.screen_name
        # end

        if self.mention?(tweet, "kilophoton")
          puts "ACCOUNT MENTIONED"
          stripped_tweet = self.strip_screen_name(tweet.text)
          normalized_tweet = { :screen_name => tweet.user.screen_name,
                               :text => stripped_tweet }
          yield normalized_tweet
        end
      end
    end
  end

  def self.reply(tweet)
    puts "got into Tweet.reply"
    puts tweet
  end

  private
  def self.mention?(tweet, screen_name)
    mentions = self.get_mentions(tweet)
    mentions.include?(screen_name)
  end

  # map tweets to their the sns they contain
  def self.get_mentions(tweet)
    tweet.user_mentions.map do |mention|
      mention.screen_name
    end
  end

  def self.strip_screen_name(text)
    # get rid of @SCREEN_NAME, remove trailing/leading whitespace
    text.gsub(/[@＠]([a-zA-Z0-9_]{1,20})/, '').strip
  end
end
