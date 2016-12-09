require "spec_helper"

describe Client do
  before do
    @client1 = Client.new(:name => 'JaRutherford', :id => nil)
  end

  describe ".all" do
    it 'returns an empty array if no clients exist' do
      expect(Client.all).to eq([])
    end
  end

  describe '#save' do
    it 'returns a client' do
      @client1.save
      expect(Client.all).to eq([@client1])
    end
  end
  describe '#==' do
    it "returns true when two objects attributes are the same" do
      client  = Client.new(:id => nil, :name => "Bruce Willis")
      expect(client).to eq(client)
    end
  end
  describe '#delete' do
    it "returns an empty array when only item is deleted" do
      client  = Client.new(:id => nil, :name => "Bruce Willis")
      client.save
      client.delete
      expect(Client.all).to eq([])
    end
  end
end
