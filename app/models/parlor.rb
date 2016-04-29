class Parlor < ActiveRecord::Base
	has_many :artists
	has_many :tats, through: :artists
	has_many :users, through: :tats
	has_many :pictures, as: :imageable
	accepts_nested_attributes_for :pictures
	include ActiveModel::Serialization
	searchkick locations: ["location"]

	attr_accessor :full_address, :location

	def street_address
		return "#{self.street_number.to_s + ' ' if self.street_number.present?}#{self.street_direction + ' ' if self.street_direction.present?}#{self.street_name + ' ' if self.street_name.present?}#{self.street_type + ' ' if self.street_type.present?}#{'# ' + self.unit if self.unit.present?}".strip
	end

	def street_address_for_geo
		"#{self.street_number.to_s + ' ' if self.street_number.present?}#{self.street_direction + ' ' if self.street_direction.present?}#{self.street_name + ' ' if self.street_name.present?}".strip
	end

	def city_and_state
		text = "#{self.city + ', ' if self.city.present?}#{self.state + ', ' if self.state.present?}#{self.zip if self.zip.present?}".strip
		if text[-1] == ','
			text = text[0..-2]
			return text
		else
			return text
		end
	end
	def full_address
		@full_address = self.street_address + ', ' + self.city_and_state
	end

	def full_address_for_geo
		self.street_address_for_geo + ', ' + self.city_and_state
	end

	def geocode
		HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{ self.full_address_for_geo }&key=#{ Rails.application.secrets.google_api }", :verify => false)
	end

	def location
		begin
			bounds = self.geocode["results"][0]["geometry"]["bounds"]
			lat = (bounds["northeast"]["lat"] + bounds["southwest"]["lat"]) / 2
			long = (bounds["northeast"]["lng"] + bounds["southwest"]["lng"]) / 2
			return  [lat, long]
		rescue
			return [0, 0]
		end
	end

	def search_data
		attributes.merge location: self.location
	end
end
