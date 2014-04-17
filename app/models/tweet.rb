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
          puts "KILOPHOTON MENTION"
          puts tweet.text
          yield tweet.text
        end
      end
    end
  end

  def self.reply(tweet)
    puts "in Tweet.reply..."
    puts tweet

    # T.update

  end

  private
  def self.mention?(tweet, screen_name)
    # map tweets to their the sns they contain
    mentions = self.get_mentions(tweet)

    mentions.include?(screen_name)
  end

  def self.get_mentions(tweet)
    tweet.user_mentions.map do |mention|
      mention.screen_name
    end
  end
end
