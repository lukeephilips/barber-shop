
require './lib/barbers'
require './lib/clients'

require 'pry-nav'
require "sinatra"
require "sinatra/reloader"
require "./lib/clients"
require "./lib/barbers"
also_reload('lib/**/*.rb')
require 'pg'

DB = PG.connect({:dbname => 'barber_shop'})

get '/' do
  @barbers = Barber.all
  @clients = Client.all
  @wait = Client.wait
  erb(:index)
end

post '/barbers/new' do
  barber_name = params['barber_name']
  specialty = params['specialty']
  Barber.new(:name => barber_name, :specialty => specialty).save
  @barbers = Barber.all
  @clients = Client.all
  @wait = Client.wait
  erb(:index)
end

get ('/barber/:id') do
  @barber = Barber.find(params['id'].to_i)
  @clients = Client.all

  erb(:barber)
end
patch ('/barber/:id') do
  id = params['id'].to_i
  @barber = Barber.find(id)
  @barber.update('name', params['update_name'])
  @barber = Barber.find(id)
  erb(:barber)
end
delete ('/barber/:id') do
  id = params['id'].to_i
  @barber = Barber.find(id)
  @barber.delete
  @barbers = Barber.all
  @clients = Client.all
  @wait = Client.wait
  erb(:index)
end

post '/clients/new' do
  name = params['name']
  preference = params['preference']
  client = Client.new(:name => name, :preference => preference)
  client.save
  client.assign_barber
  @barbers = Barber.all
  @clients = Client.all
  @wait = Client.wait
  erb(:index)
end

get ('/client/:id') do
  @client = Client.find(params['id'].to_i)
  @barbers = Barber.all
  erb(:client)
end
patch ('/client/:id') do
  id = params['id'].to_i
  @client = Client.find(id)
  @new_barber = Barber.find(params['select_barber'].to_i)
  @client.update(@new_barber)
  @client = Client.find(id)
  @barbers = Barber.all
  @clients = Client.all
  @wait = Client.wait
  erb(:index)
end
delete ('/client/:id') do
  id = params['id'].to_i
  @client = Client.find(id)
  @client.delete
  @barbers = Barber.all
  @clients = Client.all
  @wait = Client.wait
  erb(:index)
end















if !@barbers
  barber1 = Barber.new({:name => 'Jelks', :specialty => 'mustache wax'})
  barber1.save
  client1 = Client.new({:name => 'Mike', :preference => 'mustache'})
  client1.save
  client1.assign_barber
  barber2 = Barber.new({:name => 'Winthrop', :specialty => 'beard trim'})
  barber2.save
  client2 = Client.new({:name => 'Dave', :preference => 'beard trim'})
  client2.save
  client2.assign_barber
  barber3 = Barber.new({:name => 'Pemberton', :specialty => 'haircut'})
  barber3.save
  client3 = Client.new({:name => 'Jim', :preference => 'haircut'})
  client3.save
  client3.assign_barber
  barber3 = Barber.new({:name => 'DaVito', :specialty => 'shave'})
  barber3.save
  client4 = Client.new({:name => 'Kieth', :preference => 'shave'})
  client4.save
  client5 = Client.new({:name => 'Carl'})
  client5.save
end
