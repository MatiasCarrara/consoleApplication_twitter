module Twitter
  require 'json'
  require 'oauth'
  require 'dotenv'

  def self.prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(ENV['KEY'], ENV['SECRET'], site: 'https://ads.api.twitter.com')
    token_hash = { oauth_token: oauth_token, oauth_token_secret: oauth_token_secret }
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  def self.search(hashtag)
    access_token = prepare_access_token(ENV['TOKEN'], ENV['TOKEN_SECRET'])
    response = access_token.request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}&count=10").body
    back = JSON.parse(response)['statuses']
    back.map { |save| save['text'] }
  end
end
