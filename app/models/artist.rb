class Artist < ActiveRecord::Base
	has_many :tags, as: :taggable
	belongs_to :parlor
	has_many :tats

	def full_name
		return "#{self.first_name} #{self.last_name}"
	end
end
