require 'rails_helper'

require 'category'
require 'product'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before(:all) do
      @category = Category.create!(name: 'trees')
    end
    
    it "will save with all valid attributes" do
      @product = @category.products.create!(
        name: 'juniper',
        price: 50000,
        quantity: 5
      )
    end

    it "will not save with invalid name attribute" do
      @product = @category.products.create(
        name: '',
        price: 40000,
        quantity: 10
      )
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "will not save with invalid price attribute" do
      @product = @category.products.create(
        name: 'Ash',
        price: nil,
        quantity: 10
      )
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "will not save with invalid quantity attribute" do
      @product = @category.products.create(
        name: 'Arbutus',
        price: 30000,
        quantity: nil
      )
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "will not save with invalid category attribute" do
      @product = Product.create(
        name: 'Arbutus',
        price: 30000,
        quantity: 10
      )
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end