module Twitter

  require "json"
  require "oauth"

  @consumer_key        = "AA58vqAUmVe1T5VLVX1kS5zJP"
  @consumer_secret     = "571yBxW3VQIkO62i2Mrn58S8hCAaKl5RbpcC9MEzfByAchDxKg"
  @access_token        = "946407467315073024-4VXdadSPr1N4tNtCqBU44Wzc4bcjWxu"
  @access_token_secret = "awImllz0NQD1sfMu0UQzYiOBCKedOZNVFDolPTbESUzM9"

  def self.prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret  , { :site => "https://ads.api.twitter.com"})
    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
  end

  def self.here(var)
    access_token = prepare_access_token(@access_token , @access_token_secret)
    response = access_token.request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{var}&count=10").body
    var = JSON.parse(response)['statuses']
    text = []
    var.each { |lol| text.push(lol['text']) }
    print text
  end
end
