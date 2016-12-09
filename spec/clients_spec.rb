require "spec_helper"

describe Client do
  before do

  end
  describe ".all" do
    it 'returns an empty array if no clients exist' do
      expect(Client.all).to eq([])
    end
  end
end
