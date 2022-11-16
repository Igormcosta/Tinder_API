class Profile < ApplicationRecord
    validates :name, :birth_date, :genre, presence: true
end