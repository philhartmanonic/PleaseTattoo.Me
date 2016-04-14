class Artist < ActiveRecord::Base
	has_many :tags, as: :taggable
	belongs_to :parlor
	has_many :tats
	accepts_nested_attributes_for :parlor

	def full_name
		return "#{self.first_name} #{self.last_name}"
	end
end
