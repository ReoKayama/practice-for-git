class Lecture < ApplicationRecord
    has_many :reviews, dependent: :destroy
end
