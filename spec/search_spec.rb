require_relative '../search.rb'
require 'webmock/rspec'

describe Twitter do
  describe '.prepare_access_token' do
    subject { Twitter.prepare_access_token(token, token_secret) }
    let(:token) { '946407467315073024-4VXdadSPr1N4tNtCqBU44Wzc4bcjWxu' }
    let(:token_secret) { 'awImllz0NQD1sfMu0UQzYiOBCKedOZNVFDolPTbESUzM9' }
    context 'access token' do
      it 'return the access token' do
        expect(subject.token).to eq(token)
      end
    end
    context 'access token secret' do
      it 'return access to the secret token' do
        expect(subject.secret).to eq(token_secret)
      end
    end
  end

  describe '.search' do
    subject { Twitter.search(hashtag) }
    context 'search a hashtag' do
      let(:text) { 'i using facebook' }
      let(:body) do
        {
          statuses: [
            {
              created_at: 'Tue Jan 16 12:26:53 +0000 2018',
              id: 953_242_151_655_280_640,
              id_str: '953242151655280640',
              text: text
            }
          ]
        }
      end
      let(:hashtag) { 'pdpdkowejfin' }
      before do
        stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}&count=10").to_return(body: JSON(body))
      end
      it 'return the tweet text' do
        expect(subject).to eq([text])
      end
    end
  end

  describe '.topic' do
    context 'request trending topics' do
      subject { Twitter.topic }
      let(:text) { 'i using facebook' }
      let(:body) do
        [
          {
            trends: [
              {
                name: text
              }
            ]
          }
        ]
      end
      before do
        stub_request(:get, 'https://api.twitter.com/1.1/trends/place.json?id=468739').to_return(body: JSON(body))
      end
      it 'returns the name of the trend' do
        expect(subject).to eq([text])
      end
    end
  end

  describe '.bio' do
    subject { Twitter.bio(name) }
    context '' do
      let(:text) { 'Developer?' }
      let(:body) do
        {
          id: 946_407_467_315_073_024,
          id_str: '946407467315073024',
          name: 'MatiasCarrara',
          screen_name: 'matias_carrara',
          location: '',
          profile_location: nil,
          description: text
        }
      end
      let(:name) { 'matias_carrara' }
      before do
        stub_request(:get, "https://api.twitter.com/1.1/users/show.json?screen_name=#{name}").to_return(body: JSON(body))
      end
      it '' do
        expect(subject).to eq(text)
      end
    end
  end
end
