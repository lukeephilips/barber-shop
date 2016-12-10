class Client
  attr_reader(:name, :preference, :barber_id, :id, :barber_name)
  def initialize(attributes)
    @name = attributes[:name]
    @preference = attributes[:preference]
    @barber_id = attributes[:barber_id]
    @barber_name = attributes[:barber_name]
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
  def update(new_barber)
    id = new_barber.id
    name = new_barber.name
    DB.exec("UPDATE clients SET barber_id = #{id}, barber_name = '#{name}' WHERE id = #{self.id};")
  end
  def assign_barber
    preference = self.preference
    barb_id = 0
    barb_name =''
    barbers = DB.exec("SELECT * FROM barbers WHERE UPPER(specialty) LIKE UPPER('%#{preference}%')")
    barbers.each do |barber|
      barb_id = barber['id'].to_i
      barb_name = barber['name']
    end
    DB.exec("UPDATE clients SET barber_id = #{barb_id}, barber_name = '#{barb_name}' WHERE id = #{self.id} RETURNING barber_id;")
  end

  def self.all
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients;")
    returned_clients.each do |a|
      name = a['name']
      preference = a['preference']
      barber_id = a['barber_id'].to_i
      barber_name = a['barber_name']
      if !barber_name
        barber_name=  "Next Available"
      end
      id = a['id'].to_i
      clients.push(Client.new(:name => name, :preference => preference, :barber_id => barber_id, :barber_name => barber_name,:id => id, :wait => @wait))
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
  def self.wait
    count = self.all.count - Barber.all.count
    if count > 0
      @wait = (count * 15).to_s + ' minutes'
    else
      @wait = 'none'
    end
    @wait
  end
end
