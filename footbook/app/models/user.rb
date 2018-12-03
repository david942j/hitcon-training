class User < ApplicationRecord
  ADMIN_EMAIL = 'admin@footbook.tw'.freeze

  has_secure_password validations: false

  has_many :posts
  has_many :foots
  has_many :messages

  after_initialize :default_values

  private

  def default_values
  end

  class << self
    def gen_email(account)
      account + '@user.footbook.tw'
    end

    def trim_email(email)
      return nil unless email.is_a?(String)
      name, host = email.split('@')
      return nil unless name.is_a?(String) && host.is_a?(String)
      return nil if name.empty? || host.empty?
      name + '@' + host
    end
  end
end
