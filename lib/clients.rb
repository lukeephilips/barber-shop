class Client
  attr_reader(:name, :preference, :id)
  def initialize(attributes)
    @name = attributes[:name]
    @preference = attributes[:preference]
    @id = attributes[:id]
  end
  def save
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{name}') RETURNING id;")
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

  def self.all
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients;")
    returned_clients.each do |a|
      name = a['name']
      preference = a['preference']
      id = a['id'].to_i
      clients.push(Client.new(:name => name, :preference => preference, :id => id))
    end
    clients
  end
end
