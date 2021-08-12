# frozen_string_literal: true

require 'swagger_helper'

describe 'Users API' do
  path '/v1/users' do
    post 'Creates User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          name: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
        },
        required: %w(email password password_confirmation),
      }

      response '200', 'User created' do
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        let(:user) do
          {
            email: 'valid@email.com',
            name: 'Testawi',
            password: 'password',
            password_confirmation: 'password',
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:is_social) {}
        let(:user) { { email: 'fooooo' } }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end
    end
  end

  path '/v1/users/sign_in' do
    post 'Authenticate a User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: %w(email password),
      }

      response '401', ' wrong username or password' do
        let(:user) { { email: 'invalid@email.com' } }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end
    end
  end

  path '/v1/users/sign_out' do
    delete 'log out a User' do
      tags 'Users'
      consumes 'application/json'

      response '404', 'wrong username or password' do
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end
    end
  end

  path '/v1/users/password' do
    put 'Reset password using old password' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          current_password: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
        },
        required: %w(email current_password password password_confirmation),
      }

      let(:current_user) { create(:user) }
      response '401', ' wrong username or password' do
        let(:user) { { email: current_user.email } }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end
    end
  end

  path '/v1/users/passwords' do
    post 'forget password request' do
      tags 'Users'
      consumes 'multipart/form-data'
      parameter name: :email, in: :formData

      let(:user) { create(:confirmed_user) }
      response '200', 'reset password sent' do
        let(:email) { user.email }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end

      response '404', 'user not found' do
        let(:email) { 'invalid' }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end
    end
  end

  path '/v1/users/passwords' do
    put 'reset password by reset password token' do
      tags 'Users'
      consumes 'multipart/form-data'
      parameter name: :reset_password_token, in: :query, type: :string
      parameter name: :password, in: :formData
      parameter name: :password_confirmation, in: :formData

      let(:confirmed_user) { create(:confirmed_user) }
      response '200', 'reset password sent' do
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        let(:reset_password_token) { confirmed_user.reset_password_token }
        let(:password) { 'newPassword' }
        let(:password_confirmation) { 'newPassword' }
        run_test!
      end

      response '422', 'invalid request' do
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        let(:reset_password_token) { confirmed_user.reset_password_token }
        let(:password) { 'newPassworddd' }
        let(:password_confirmation) { 'newPassword' }
        run_test!
      end

      response '404', 'User not found' do
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        let(:reset_password_token) { 'invalidPasswordToken' }
        let(:password) { 'newPassworddd' }
        let(:password_confirmation) { 'newPassword' }
        run_test!
      end
    end
  end

  path '/v1/users/confirmations' do
    post 'Resend confirmation instructions' do
      tags 'Users'
      consumes 'multipart/form-data'
      parameter name: :email, in: :query, type: :string

      let(:confirmed_user) { create(:confirmed_user) }
      response '200', 'confirmation instructions sent' do
        let(:email) { confirmed_user.email }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end

      response '404', 'User not found' do
        let(:email) { 'invalid email' }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end
    end
  end

  path '/v1/users/confirmations' do
    put 'complete user profile' do
      tags 'Users'
      consumes 'multipart/form-data'
      parameter name: :confirmation_token, in: :query, type: :string
      parameter name: 'user[password]', in: :formData
      parameter name: 'user[password_confirmation]', in: :formData
      parameter name: 'user[name]', in: :formData

      let(:confirmed_user) { create(:confirmed_user) }
      response '200', 'User created by invitation' do
        let(:confirmation_token) { confirmed_user.confirmation_token }
        let('user[name]') { 'name' }
        let('user[password]') { 'password' }
        let('user[password_confirmation]') { 'password' }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end

      response '404', 'not found' do
        let(:confirmation_token) { 'invalid' }
        let('user[name]') { 'name' }
        let('user[password]') { 'password' }
        let('user[password_confirmation]') { 'password' }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end

      response '422', 'invalid attributes' do
        let(:confirmation_token) { confirmed_user.confirmation_token }
        let('user[name]') { 'name' }
        let('user[password]') { 'passworddd' }
        let('user[password_confirmation]') { 'password' }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end
    end
  end

  path '/v1/users/confirmations/confirm' do
    put 'confirm User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :confirmation_token, in: :query, type: :string
      let(:confirmed_user) { create(:confirmed_user) }
      response '200', 'User got confirmed' do
        let(:confirmation_token) { confirmed_user.confirmation_token }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end

      response '404', 'not found' do
        let(:confirmation_token) { 'invalid' }
        let(:client) {}
        let(:token) {}
        let(:uid) {}
        run_test!
      end
    end
  end
end
