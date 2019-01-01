class User < ApplicationRecord
  after_destroy :prevent_destruction_of_last_admin

  validates :name, presence: true, uniqueness: true
  has_secure_password

  class Error < StandardError
  end

  private

  def prevent_destruction_of_last_admin
    unless User.first 
      raise Error.new "Can't delete final remaining admin user!"
    end
  end
end
