require_relative "../search.rb"
require "webmock/rspec"

describe Twitter do
  describe ".prepare_access_token" do

    subject { Twitter.prepare_access_token(token, token_secret ) }
      let(:token) { "946407467315073024-4VXdadSPr1N4tNtCqBU44Wzc4bcjWxu" }
      let(:token_secret) { "awImllz0NQD1sfMu0UQzYiOBCKedOZNVFDolPTbESUzM9" }

      context "token" do
          it '' do
           expect(subject.token).to eq(token)
          end
      end
      context "token_secret" do
          it '' do
            expect(subject.secret).to eq(token_secret)
          end
      end
  end

  describe ".here" do

    subject { Twitter.here(tag) }
    context "buscar" do

        let(:text) { "mi name es Matias" }
        let(:body) do  {
          statuses: [
            {
              created_at: "Thu Jan 11 14:11:01 +0000 2018",
              id: 951456415025172481,
              id_str: "951456415025172481",
              text: text,
              }]
            }
          end

          let(:tag) { "Penarol" }
          before do
            stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{tag}&count=10").to_return(body: JSON(body))
         end

         # subject { Twitter.here(tag) }
         # it { is_expected.to eq(text) }

        it 'hola' do
          expect(subject).to eq(text)
        end

    end
  end
end
