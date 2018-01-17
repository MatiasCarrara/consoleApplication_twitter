require_relative "../search.rb"
require "webmock/rspec"

describe Twitter do

  describe ".prepare_access_token" do
    subject { Twitter.prepare_access_token(token, token_secret ) }
    let(:token) { "946407467315073024-4VXdadSPr1N4tNtCqBU44Wzc4bcjWxu" }
    let(:token_secret) { "awImllz0NQD1sfMu0UQzYiOBCKedOZNVFDolPTbESUzM9" }
    context "access token" do
      it '' do
        expect(subject.token).to eq(token)
      end
    end
    context "access token secret" do
      it '' do
        expect(subject.secret).to eq(token_secret)
      end
    end
  end

  describe ".search" do
    subject { Twitter.search(hashtag) }
    context "search a hashtag" do
      let(:text) { "i using facebook" }
      let(:body) do  {
        statuses: [{
            created_at: "Tue Jan 16 12:26:53 +0000 2018",
            id: 953242151655280640,
            id_str: "953242151655280640",
            text: text,
            }] }
          end
      let(:hashtag) { "pdpdkowejfin" }
      before do
        stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}&count=10").to_return(body: JSON(body))
      end
      it 'return the tweet text' do
        expect(subject).to eq([text])
      end
    end
  end
end
