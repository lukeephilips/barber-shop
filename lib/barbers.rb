class Barber
  attr_reader(:name, :specialty, :id)
  def initialize(attributes)
    @name = attributes[:name]
    @specialty = attributes[:specialty]
    @id = attributes[:id]
  end
  def save
    result = DB.exec("INSERT INTO barbers (name) VALUES ('#{name}') RETURNING id;")
    @id = result[0]['id'].to_i
  end
  def ==(other)
    (self.name == other.name)
  end
  def delete
    DB.exec("DELETE FROM barbers WHERE id = #{self.id()};")
    binding.pry
    DB.exec("UPDATE clients SET barber_id = NULL WHERE barber_id = #{self.id()};")
  end
  def update(key, value)
    DB.exec("UPDATE barbers SET #{key} = '#{value}' WHERE id = #{self.id};")
  end
  def clients
    client_list = []
    clients = DB.exec("SELECT * FROM clients WHERE barber_id = #{self.id};")
    clients.each do |client|
      name = client['name']
      id = client['id'].to_i
      preference = client['preference']
      client_list.push(Client.new(:name => name, :preference => preference, :id => id))
    end
    client_list
  end

  def self.all
    barbers = []
    returned_barbers = DB.exec("SELECT * FROM barbers;")
    returned_barbers.each do |a|
      name = a['name']
      specialty = a['specialty']
      id = a['id'].to_i
      barbers.push(Barber.new(:name => name, :specialty => specialty, :id => id))
    end
    barbers
  end
  def self.find(id)
    found_barber = nil
    Barber.all.each do |barber|
      if barber.id == id
        found_barber = barber
      end
    end
    found_barber
  end
end
