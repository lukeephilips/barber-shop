require('rspec')
require('pry-nav')
require('barbers')
require('clients')
require('pg')

# DB = PG.connect ({:dbname => 'barber_shop_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM barbers *;")
    DB.exec("DELETE FROM clients *;")
  end
end
