require 'factory_bot_rails'

FactoryBot.define do
    factory :profile do
        name { 'Maria' }
        birth_date { '1999-12-26' }
        genre { 'Female' }
    end
end