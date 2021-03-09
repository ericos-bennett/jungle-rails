require 'rails_helper'

require 'user'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "will save with all valid attributes" do
      @user = User.create!(
        first_name: 'Lolo',
        last_name: 'Zva', 
        email: 'lolo@gmail.com', 
        password: '12345', 
        password_confirmation: '12345'
      )
    end

    it "will not save if the password confirmation != password" do
      @user = User.create(
        first_name: 'Fred',
        last_name: 'Manny',
        email: 'fred@gmail.com', 
        password: '12345', 
        password_confirmation: '12346'
      )
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end


    it "will not save with invalid first_name" do
      @user = User.create(
        first_name: '',
        last_name: 'Manny',
        email: 'fred@gmail.com', 
        password: '12345', 
        password_confirmation: '12345'
      )
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "will not save with invalid last_name" do
      @user = User.create(
        first_name: 'Fred',
        last_name: '',
        email: 'fred@gmail.com', 
        password: '12345', 
        password_confirmation: '12345'
      )
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "will not save with invalid email" do
      @user = User.create(
        first_name: 'Fred',
        last_name: 'Manny',
        email: '', 
        password: '12345', 
        password_confirmation: '12345'
      )
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "will not allow 2 accounts with the same email (case insensitve)" do
      @user1 = User.create(
        first_name: 'Fred',
        last_name: 'Manny',
        email: 'freddie@gmail.com', 
        password: '12345', 
        password_confirmation: '12345'
      )
      @user2 = User.create(
        first_name: 'Fred',
        last_name: 'Manny',
        email: 'freddie@gmail.com', 
        password: '12345', 
        password_confirmation: '12345'
      )
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "will not save with a 4 digit password (too short)" do
      @user = User.create(
        first_name: 'Lolo',
        last_name: 'Zva', 
        email: 'lolo@gmail.com', 
        password: '1234', 
        password_confirmation: '1234'
      )
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    # it "will trim an email's whitespace before saving" do
    #   @user = User.create(
    #     first_name: 'Lolo',
    #     last_name: 'Zva', 
    #     email: '  lolo@gmail.com  ', 
    #     password: '12345', 
    #     password_confirmation: '12345'
    #   )
    #   p @user
    #   expect(@user[:email]).to eq('lolo@gmail.com')
    # end

  end

  describe '.authenticate_with_credentials' do

    it "will return the user if authenticated with the correct password" do
      @user = User.create!(
        first_name: 'Lolo',
        last_name: 'Zva', 
        email: 'lolo@gmail.com', 
        password: '12342', 
        password_confirmation: '12342'
      )
      expect(User.authenticate_with_credentials(@user[:email], '12342')).to eq(@user)
    end

    it "will return false if authenticated with the incorrect data" do
      @user = User.create!(
        first_name: 'Lolo',
        last_name: 'Zva', 
        email: 'lolo@gmail.com', 
        password: '12342', 
        password_confirmation: '12342'
      )
      expect(User.authenticate_with_credentials(@user[:email], '12345')).to be false
    end

    it "will return the user if authenticated with the email with spacing" do
      @user = User.create!(
        first_name: 'Lolo',
        last_name: 'Zva', 
        email: 'lolo@gmail.com', 
        password: '12342', 
        password_confirmation: '12342'
      )
      expect(User.authenticate_with_credentials('  lolo@gmail.com  ', '12342')).to eq(@user)
    end

    it "will return the user if authenticated with a case insensitive email" do
      @user = User.create!(
        first_name: 'Lolo',
        last_name: 'Zva', 
        email: 'lolo@gmail.com', 
        password: '12342', 
        password_confirmation: '12342'
      )
      expect(User.authenticate_with_credentials('LOLO@gmail.com', '12342')).to eq(@user)
    end

  end

end