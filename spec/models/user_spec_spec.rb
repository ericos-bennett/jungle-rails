require 'rails_helper'

require 'user'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "will save with all valid attributes" do
      @user = User.create!(
        first_name: 'Lolo',
        last_name: 'Zva', 
        email: 'lolo@gmail.com', 
        password: '1234', 
        password_confirmation: '1234'
      )
    end

    it "will not save if the password confirmation != password" do
      @user = User.create(
        first_name: 'Fred',
        last_name: 'Manny',
        email: 'fred@gmail.com', 
        password: '1234', 
        password_confirmation: '12'
      )
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end


    it "will not save with invalid first_name" do
      @user = User.create(
        first_name: '',
        last_name: 'Manny',
        email: 'fred@gmail.com', 
        password: '1234', 
        password_confirmation: '1234'
      )
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "will not save with invalid last_name" do
      @user = User.create(
        first_name: 'Fred',
        last_name: '',
        email: 'fred@gmail.com', 
        password: '1234', 
        password_confirmation: '1234'
      )
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "will not save with invalid email" do
      @user = User.create(
        first_name: 'Fred',
        last_name: 'Manny',
        email: '', 
        password: '1234', 
        password_confirmation: '1234'
      )
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "will not allow 2 accounts with the same email (case insensitve)" do
      @user1 = User.create(
        first_name: 'Fred',
        last_name: 'Manny',
        email: 'freddie@gmail.com', 
        password: '1234', 
        password_confirmation: '1234'
      )
      @user2 = User.create(
        first_name: 'Fred',
        last_name: 'Manny',
        email: 'freddie@gmail.com', 
        password: '1234', 
        password_confirmation: '1234'
      )
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

  end
end