
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

binding.pry
# seed database with staff and clients
if !Barber.all.any?
  staff = {"Jelks" => "mustache wax", 'Winthrop' => 'beard trim','Pemberton' => 'haircut', 'DaVito' => 'shave'}
  regulars = {'Mike' => 'mustache', 'Dave' => 'beard trim','Jim' => 'haircut','Kieth' => 'shave','Carl' => 'cornrows'}

  staff.each do |a,b|
    barber = Barber.new(:id => nil, :name => a, :specialty => b)
    barber.save
  end
  regulars.each do |a,b|
    client = Client.new(:name => a, :preference => b )
    client.save
    client.assign_barber
  end
end
