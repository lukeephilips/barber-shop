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
  describe '#delete' do
    it "returns an empty array when only item is deleted" do
      barber  = Barber.new(:id => nil, :specialty => 'fades', :name => "Darius")
      barber.save
      barber.delete
      expect(Barber.all).to eq([])
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
end
