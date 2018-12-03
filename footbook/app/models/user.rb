class User < ApplicationRecord
  has_secure_password validations: false

  has_many :posts
  has_many :foots
  has_many :messages

  after_initialize :default_values

  def admin?
    self.id == 1
  end

  private

  def default_values
  end
end
