require 'pry'
require'capybara/rspec'
require('./app')
Capybara.app = Sinatra::Application
# set(:show_exceptions, false)

describe('the home path', {:type => :feature}) do
  before do
    visit '/'
  end
  it 'loads' do
    expect(page).to have_content "Barber"
  end
  it 'allows adding a barber' do
    fill_in('barber_name', :with => 'Jeeves')
    select('mustache wax', :from => 'specialty')
      click_button('Join')
      expect(page).to have_content "Jeeves"
  end
end
