class Client
  attr_reader(:name, :preference, :barber_id, :id)
  def initialize(attributes)
    @name = attributes[:name]
    @preference = attributes[:preference]
    @barber_id = attributes[:barber_id]
    @id = attributes[:id]
  end
  def save
    result = DB.exec("INSERT INTO clients (name, preference) VALUES ('#{name}', '#{preference}') RETURNING id;")
    @id = result[0]['id'].to_i
  end
  def ==(other)
    (self.name == other.name)
  end
  def delete
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end
  def update(key, value)
    DB.exec("UPDATE clients SET #{key} = '#{value}' WHERE id = #{self.id};")
  end
  def assign_barber(barber)
    DB.exec("UPDATE clients SET barber_id = '#{barber.id}' WHERE id = #{self.id};")
  end

  def self.all
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients;")
    returned_clients.each do |a|
      name = a['name']
      preference = a['preference']
      barber_id = a['barber_id'].to_i
      id = a['id'].to_i
      clients.push(Client.new(:name => name, :preference => preference, :barber_id => barber_id, :id => id))
    end
    clients
  end
  def self.find(id)
    found_client = nil
    Client.all.each do |client|
      if client.id == id
        found_client = client
      end
    end
    found_client
  end
end
