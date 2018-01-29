require 'json'
require 'oauth'
require 'dotenv'

module Twitter

  Dotenv.load('.env')

  def self.prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(ENV['KEY'], ENV['SECRET'], site: 'https://ads.api.twitter.com')
    token_hash = { oauth_token: oauth_token, oauth_token_secret: oauth_token_secret }
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  @access_token = prepare_access_token(ENV['TOKEN'], ENV['TOKEN_SECRET'])
  
  def self.search(hashtag)
    response = @access_token.request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}&count=10").body
    back = JSON.parse(response)['statuses']
    back.map { |save| save['text'] }
  end

  def self.topic
    response = @access_token.request(:get, 'https://api.twitter.com/1.1/trends/place.json?id=468739').body
    back = JSON.parse(response).first['trends']
    text = []
    back.each { |save| text.push(save['name']) }
    text
  end

  def self.bio(name)
    response = @access_token.request(:get, "https://api.twitter.com/1.1/users/show.json?screen_name=#{name}").body
    back = JSON.parse(response)
    back['description']
  end
end
