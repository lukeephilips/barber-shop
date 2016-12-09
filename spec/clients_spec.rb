require "spec_helper"

describe Client do
  before do
    @client1 = Client.new(:name => 'JaRutherford', :preference => 'trim', :id => nil)
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
      client  = Client.new(:id => nil, :preference => 'trim', :name => "Bruce Willis")
      expect(client).to eq(client)
    end
  end
  describe '#delete' do
    it "returns an empty array when only item is deleted" do
      client  = Client.new(:id => nil, :preference => 'trim', :name => "Bruce Willis")
      client.save
      client.delete
      expect(Client.all).to eq([])
    end
  end
  describe '#update' do
    it "updates a clients preference" do
      client  = Client.new(:id => nil, :preference => 'trim', :name => "Bruce Willis")
      client.save
      barber = Barber.new(:id => nil, :specialty => 'test', :name => 'Randal')
      barber.save
      client.update(barber)
      expect(Client.all[0].barber_name).to eq('Randal')
    end
  end
  describe '#assign_barber' do
    it "assigns client to the correct barber" do
      barber4 = Barber.new(:id => nil, :specialty => 'test', :name => 'Randal')
      barber4.save

      client4  = Client.new(:barber_id => nil, :id => nil, :preference => 'test', :name => "Bruce Willis")
      client4.save
      client4.assign_barber
      expect(Client.find(client4.id).barber_id).to eq(barber4.id)
    end
  end
  describe '#assign_barber' do
    it "assigns client to no barber when they want something weird" do
      barber4 = Barber.new(:id => nil, :specialty => 'beard', :name => 'Randal')
      barber4.save

      client4  = Client.new(:barber_id => nil, :id => nil, :preference => 'test', :name => "Bruce Willis")
      client4.save
      client4.assign_barber
      expect(Client.find(client4.id).barber_id).to eq(0)
    end
  end
end
