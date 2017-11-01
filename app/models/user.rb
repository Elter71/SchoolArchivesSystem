class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :posts
  before_validation :set_default_role
  validates_with UserValidator

  def role?(role_sym)
    role.name.underscore.to_sym == role_sym
  end

  def ability
    Ability.new(self)
  end

  private

  def set_default_role
    self.role = Role.find_by_name('user') if role.nil?
  end
end
