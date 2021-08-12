# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::NationalIdsController, type: :controller do
  before { allow(Time.zone).to receive(:now) { Date.parse('12/8/2021') }}
  describe 'GET #show' do
    context 'when id is valid' do
      it 'returns success' do
        get :show, params: { id: "30403298800136" }
        expect(response).to be_successful
      end
    end

    context 'when day is 29 but it is a leap year' do
      it 'returns success' do
        get :show, params: { id: "30402298800136" }
        expect(response).to be_successful
      end
    end


    context 'when month is 31 days' do
      it 'returns success' do
        get :show, params: { id: "30401318800136" }
        expect(response).to be_successful
      end
    end



    context 'when id length is more than 14' do
      it 'fail' do
        get :show, params: { id: "304032988001360" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when id length is less than 14' do
      it 'fail' do
        get :show, params: { id: "3040329880013" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when birth year is 00' do
      it 'fail' do
        get :show, params: { id: "30003298800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when generation digit is not valid' do
      it 'fail' do
        get :show, params: { id: "40403298800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when birth day is more than 31' do
      it 'fail' do
        get :show, params: { id: "30403328800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when birth day is 00' do
      it 'fail' do
        get :show, params: { id: "30402008800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when birth month is more than 12' do
      it 'fail' do
        get :show, params: { id: "30413298800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when birth month is 00' do
      it 'fail' do
        get :show, params: { id: "30400298800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end


    context 'when birth month is only 30 days' do
      it 'fails' do
        get :show, params: { id: "30406318800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end



    context 'when birth month is only 28 days' do
      it 'fails' do
        get :show, params: { id: "30302308800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end



    context 'when governorate number is not valid' do
      it 'fails' do
        get :show, params: { id: "30403298900136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end


    context 'when birth year is less than 16' do
      it 'fails' do
        get :show, params: { id: "30903298800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when birth date is going to be 16 later this year' do
      it 'fail' do
        get :show, params: { id: "30510298800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when birth date is less than min age by days' do
      it 'fail' do
        get :show, params: { id: "3058148800136" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when there is non characters values' do
      it 'fail' do
        get :show, params: { id: "30581488001aa" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


end
