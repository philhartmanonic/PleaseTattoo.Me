class Tat < ActiveRecord::Base
	belongs_to :artist
	belongs_to :user
	has_many :tags, as: :taggable
	has_many :pictures, as: :imageable
	accepts_nested_attributes_for :pictures
end
