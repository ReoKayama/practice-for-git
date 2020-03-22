class User < ApplicationRecord
    has_many :favorites, dependent: :destroy
    
    before_save { self.email = self.email.downcase }
    
    validates :name, presence: true, length: {maximum: 20}
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
    validates :email, presence: true, length: {maximum: 112}, format: {with: VALID_EMAIL_REGEX}, 
                uniqueness: { case_sensitive: false }
    
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    validates :major, presence: true
    
    validates :grade, presence: true
    
    
    
    def User.digest(string) 
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                      BCrypt::Engine.cost 
        BCrypt::Password.create(string, cost: cost) 
    end 
    
end
