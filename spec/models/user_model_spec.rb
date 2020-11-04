require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User validates' do 
    context 'with email and password' do
      it 'should be ok' do
        user = User.new(
          email: Faker::Internet.email,
          password: Faker::String.random
        )
        expect(user).to be_valid
      end
    end

    context 'without email' do
      it 'should not be ok' do
        user = User.new(
          email: "",
          password: Faker::String.random
        )
        expect(user).not_to be_valid
      end
    end

    context 'without password' do
      it 'should not be ok' do
        user = User.new(
          email: Faker::Internet.email,
          password: ""
        )
        expect(user).not_to be_valid
      end
    end

    context 'without email and password' do
      it 'should not be ok' do
        user = User.new(
          email: "",
          password: ""
        )
        expect(user).not_to be_valid
      end
    end

    context 'incorrect email' do
      it 'should not be ok' do
        user = User.new(
          email: "abcde",
          password: Faker::String.random
        )
        expect(user).not_to be_valid
      end
    end

    context 'password too short' do
      it 'should not be ok' do
        user = User.new(
          email: Faker::Internet.email,
          password: '123'
        )
        expect(user).not_to be_valid
      end
    end
    
  end


end
