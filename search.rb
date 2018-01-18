module Twitter
  require 'json'
  require 'oauth'

  KEY = 'AA58vqAUmVe1T5VLVX1kS5zJP'.freeze
  SECRET = '571yBxW3VQIkO62i2Mrn58S8hCAaKl5RbpcC9MEzfByAchDxKg'.freeze
  TOKEN = '946407467315073024-4VXdadSPr1N4tNtCqBU44Wzc4bcjWxu'.freeze
  TOKEN_SECRET = 'awImllz0NQD1sfMu0UQzYiOBCKedOZNVFDolPTbESUzM9'.freeze

  def self.prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(KEY, SECRET, site: 'https://ads.api.twitter.com')
    token_hash = { oauth_token: oauth_token, oauth_token_secret: oauth_token_secret }
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  def self.search(hashtag)
    access_token = prepare_access_token(TOKEN, TOKEN_SECRET)
    response = access_token.request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}&count=10").body
    back = JSON.parse(response)['statuses']
    back.map { |save| save['text'] }
  end
end
