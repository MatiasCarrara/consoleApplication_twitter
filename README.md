# consoleApplication_twitter
require_relative '../ej3.rb'

describe Exercise3 do
  describe '.contains?' do
    let(:string) { %w[a b c] }
    context 'I pass a letter that is in the array' do
      let(:letter) { 'a' }
      subject { Exercise3.contains?(string, letter) }
      it { is_expected.to eq(true) }
    end
    context 'I pass a letter that is not in the array' do
      let(:letter) { 'r' }
      subject { Exercise3.contains?(string, letter) }
      it { is_expected.to eq(false) }
    end
    context 'I pass an empty space, in a full array' do
      let(:letter) { '' }
      subject { Exercise3.contains?(string, letter) }
      it { is_expected.to eq(false) }
    end
    context 'I pass an empty space, in a array with an empty space' do
      let(:array) { ['a', 'b', ''] }
      let(:letter) { '' }
      subject { Exercise3.contains?(array, letter) }
      it { is_expected.to eq(true) }
    end
  end
end
