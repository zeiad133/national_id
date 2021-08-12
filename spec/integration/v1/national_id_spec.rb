# frozen_string_literal: true

require('swagger_helper')

describe 'National ID API' do

  path '/national_ids/{id}' do
    get 'Retrieves national id info' do
      tags 'National ID'
      produces 'application/json'
      parameter name: :id, in: :path

      response '200', 'National ID fetched' do
        let(:id) { '29402278800136' }
        run_test!
      end

      response '422', 'Invalid ID' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
