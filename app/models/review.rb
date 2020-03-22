class Review < ApplicationRecord
    belongs_to :lecture
    
    validates :lecture_id, presence: true
end
