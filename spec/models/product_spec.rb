require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'Saves with a name, price, quantity and category' do 
      @category = Category.new(name: 'fern')
      expect(@product = Product.new(name: "Ferny", price: 1, quantity: 1, category: @category)).to be_a Product
    end
    
    it 'throws error on product with no name' do
      @category = Category.new(name: 'fern')
      @product = Product.new(price: 1, quantity: 1, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include ("Name can't be blank")
    end

    it 'throws error on product with no price' do
      @category = Category.new(name: 'fern')
      @product = Product.new(name: "Ferny", quantity: 1, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include ("Price can't be blank")
    end

    it 'throws error on product with no quantity' do
      @category = Category.new(name: 'fern')
      @product = Product.new(name: "Ferny", price: 1, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include ("Quantity can't be blank")
    end

    it 'throws error on product with no category' do
     @product = Product.new(name: "Ferny", price: 1, quantity: 1)
     @product.save
     expect(@product.errors.full_messages).to include ("Category can't be blank")
    end
  end
end
