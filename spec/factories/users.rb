# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'factory Name' }
    email { "user_#{SecureRandom.hex}@example.com" }
    password { 'password' }
    trait :with_post_like do
      post_likes { create_list(:post_like, 1) }
    end

    factory :confirmed_user do
      confirmed_at { Time.zone.now }
      confirmation_token { 'confirmationToken' }
      reset_password_token { 'resetPassword' }
    end
  end
end
