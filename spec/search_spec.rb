require_relative '../search.rb'

describe "Twitter" do
  describe ".here" do
    context '' do
      let(:var) { %w[Penarol] }
      let(:lol) {  }
      subject { Twitter.here(var) }
      it { is_expected.to eq(lol) }
    end

  end
end
