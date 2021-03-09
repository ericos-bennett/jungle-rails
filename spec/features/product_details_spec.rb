require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Clicking on a product brings you to its page" do
    # ACT
    visit root_path
    
    # VERIFY
    selector = 'body > main > section > div > article:nth-child(1) > header > a'
    expect(page).to have_css selector
    find(selector).click
    
    find('h1', text: '»' )
    
    # DEBUG
    save_screenshot

  end

end
