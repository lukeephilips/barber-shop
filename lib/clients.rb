class Client
  attr_reader(:name, :id)
  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end
  def save
    result = DB.exec("INSERT INTO clients (name, id) VALUES ('#{name}') RETURNING id;")
    @id = result[0]['id'].to_i
  end
  def self.all
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients.each do |a|
      name = a['name']
      id = a['id'].to_i
      clients.push({:name => name, :id => id})
    end
    clients
  end
end
