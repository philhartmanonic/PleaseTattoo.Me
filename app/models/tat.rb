class Tat < ActiveRecord::Base
	belongs_to :artist
	has_many :tags, as: :taggable
end
