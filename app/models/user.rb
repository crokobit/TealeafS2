class User < ActiveRecord::Base
  include Sluggable
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  before_save :generate_slug

  sluggable_column :name

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
end
