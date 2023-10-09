class User < ApplicationRecord
	has_secure_password
	validates :first_name, :email, presence: true
	validates :role, inclusion: { in: %w(user admin), message: "%{value} is not a valid role" }
	validates :email, uniqueness: true
	after_create :create_user_in_iterable

	def full_name
		"#{first_name} #{last_name}"
	end

	def is_admin?
		role == "admin"
	end

	private
		def create_user_in_iterable
			begin
				Iterable::User.create(self)
			rescue => e
				Rails.logger.info(e.message);
			end
		end
end