require "spec_helper"

describe Barber do
  before do
    @barber1 = Barber.new(:name => 'JaRutherford', :specialty => 'braids', :id => nil)
  end

  describe ".all" do
    it 'returns an empty array if no barbers exist' do
      expect(Barber.all).to eq([])
    end
  end

  describe '#save' do
    it 'returns a barber' do
      @barber1.save
      expect(Barber.all).to eq([@barber1])
    end
  end
  describe '#==' do
    it "returns true when two objects attributes are the same" do
      barber  = Barber.new(:id => nil, :specialty => 'fades', :name => "Darius")
      expect(barber).to eq(barber)
    end
  end
  # describe '#delete' do
  #   it "returns an empty array when only item is deleted" do
  #     barber  = Barber.new(:id => nil, :specialty => 'fades', :name => "Darius")
  #     barber.save
  #     barber.delete
  #     expect(Barber.all).to eq([])
  #   end
  # end
  describe '#delete' do
    it 'removes barber_id from client when a barber is deleted' do
      new_barber  = Barber.new(:id => nil, :specialty => 'fades', :name => "Kyle")
      new_barber.save
      client  = Client.new(:id => nil, :barber_id => new_barber.id, :name => "Tim")
      client.save
      client.assign_barber(new_barber)
      new_barber.delete
      expect(Client.find(client.id).barber_id).to eq(0)
    end
  end
  describe '#update' do
    it "updates a barbers specialty" do
      barber  = Barber.new(:id => nil, :specialty => 'fades', :name => "Darius")
      barber.save
      barber.update('specialty', 'shave')
      expect(Barber.all[0].specialty).to eq('shave')
    end
  end
  describe '.find' do
    it 'returns a barber by id' do
      @barber1.save
      expect(Barber.find(@barber1.id)).to eq(@barber1)
    end
  end
  describe '#clients' do
    it 'returns a client list for a provided barber' do
      @barber1.save
      client  = Client.new(:id => nil, :barber_id => @barber1.id, :name => "LaMichael")
      client.save
      client.assign_barber(@barber1)
      expect(@barber1.clients).to eq([client])
    end
  end
end
