require_relative "../search.rb"

describe Twitter do
  describe ".here" do
    let(:tag) {"Penarol"}
    subject { Twitter.here(tag) }
   it { is_expected.to eq(true) }
  end
end
