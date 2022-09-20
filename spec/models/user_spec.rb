require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'Saves a user with a valid first name, last name, email and password' do 
      @user = User.new(first_name: 'Jaeden', last_name: 'West', email: 'email@gmail.com', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user).to be_a User
    end

    it 'Does not save with a password shorter than 8 characters' do 
      @user = User.new(first_name: 'Jaeden', last_name: 'West', email: 'email@gmail.com', password: 'pass', password_confirmation: 'pass')
      @user.save
      expect(@user.errors.full_messages).to include ("Password is too short (minimum is 8 characters)")
    end

    it "Does not save when password and password_confirmation are not the same" do
      @user = User.new(first_name: 'Jaeden', last_name: 'West', email: 'email@gmail.com', password: 'password', password_confirmation: 'passwords')
      @user.save
      expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
    end

    it "Does not save without a password" do
      @user = User.new(first_name: 'Jaeden', last_name: 'West', email: 'email@gmail.com', password_confirmation: 'password')
      @user.save
      expect(@user.errors.full_messages).to include ("Password can't be blank")
    end

    it "Does not save without a password confirmation" do
      @user = User.new(first_name: 'Jaeden', last_name: 'West', email: 'email@gmail.com', password: 'password')
      @user.save
      expect(@user.errors.full_messages).to include ("Password confirmation can't be blank")
    end

    it "Does not save without an email" do 
      @user = User.new(first_name: 'Jaeden', last_name: 'West', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user.errors.full_messages).to include ("Email can't be blank")
    end

    it "Does not save without a first name" do 
      @user = User.new(last_name: 'West', email: 'email@gmail.com', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user.errors.full_messages).to include ("First name can't be blank")
    end

    it "Does not save without a last name" do 
      @user = User.new(first_name: 'Jaeden', email: 'email@gmail.com', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user.errors.full_messages).to include ("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    it "Returns a user instance when the correct credentials are used to sign in" do
      @user = User.new(first_name: 'Jaeden', last_name: 'West', email: 'email@gmail.com', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user).to be_a User
      expect(@user.authenticate_with_credentials('email@gmail.com', 'password')).to eq(@user)
    end

    it "Is unaffected by improper casing of the email" do
      @user = User.new(first_name: 'Jaeden', last_name: 'West', email: 'email@gmail.com', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user).to be_a User
      expect(@user.authenticate_with_credentials('emAil@GmaiL.Com', 'password')).to eq(@user)
    end

    it "Is unaffected by starting and trailing whitespace on the email" do
      @user = User.new(first_name: 'Jaeden', last_name: 'West', email: 'email@gmail.com', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user).to be_a User
      expect(@user.authenticate_with_credentials('  email@gmail.com ', 'password')).to eq(@user)
    end

  end


end
