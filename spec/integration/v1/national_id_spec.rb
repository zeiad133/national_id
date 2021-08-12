# # frozen_string_literal: true

# require('swagger_helper')

# describe 'Self Users API' do
#   let(:user) { create(:confirmed_user) }
#   let(:auth_headers) { user.create_new_auth_token }

#   before do
#     user
#   end

#   path '/v1/users/self' do
#     get 'Retrieves Self profile' do
#       tags 'Self'
#       produces 'application/json'

#       response '200', 'Profile fetched' do
#         let(:client) { auth_headers['client'] }
#         let(:token) { auth_headers['token'] }
#         let(:uid) { auth_headers['uid'] }
#         run_test!
#       end
#     end
#   end

#   path '/v1/users/self' do
#     patch 'Updates Profile' do
#       tags 'Self'
#       consumes 'multipart/form-data'
#       produces 'application/json'

#       parameter name: 'user[name]', in: :formData, type: :string
#       parameter name: 'user[email]', in: :formData, type: :string

#       response '200', 'Profile updated' do
#         let('user[name]') { 'MyString' }
#         let('user[email]') { 'string@gmail.com' }

#         let(:client) { auth_headers['client'] }
#         let(:token) { auth_headers['token'] }
#         let(:uid) { auth_headers['uid'] }
#         run_test!
#       end

#       response '422', 'Invalid request' do
#         let('user[name]') { 'name' }
#         let('user[email]') { 'invalid' }
#         let(:client) { auth_headers['client'] }
#         let(:token) { auth_headers['token'] }
#         let(:uid) { auth_headers['uid'] }
#         run_test!
#       end

#       response '401', 'User not signed in' do
#         let('user[name]') { 'MyString' }
#         let('user[email]') { 'string@gmail.com' }
#         let(:client) {}
#         let(:token) {}
#         let(:uid) {}
#         run_test!
#       end
#     end
#   end
# end
