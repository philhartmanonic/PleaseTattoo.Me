class Tat < ActiveRecord::Base
	belongs_to :artist
	belongs_to :user
	has_many :tags, as: :taggable
end
