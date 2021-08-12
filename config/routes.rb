# frozen_string_literal: true


Rails.application.routes.draw do
  unless Rails.env.production?
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end

  namespace :v1 do
    resources :national_ids, only: [] do
      member {get :show}
    end
  end
end
