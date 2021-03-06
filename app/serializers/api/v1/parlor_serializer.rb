class Api::V1::ParlorSerializer < Api::V1::BaseSerializer
	attributes :id, :name, :full_address, :location, :pictures, :artists

	def street_address
		"#{object.street_number.to_s + ' ' if object.street_number.present?}#{object.street_direction + ' ' if object.street_direction.present?}#{object.street_name + ' ' if object.street_name.present?}#{object.street_type + ' ' if object.street_type.present?}#{'# ' + object.unit if object.unit.present?}".strip
	end

	def city_and_state
		text = "#{object.city + ', ' if object.city.present?}#{object.state + ', ' if object.state.present?}#{object.zip if object.zip.present?}".strip
		if text[-1] == ','
			text = text[0..-2]
			return text
		else
			return text
		end
	end
	
	def full_address
		object.street_address + ', ' + object.city_and_state
	end

	def pictures
		object.pictures
	end

	def artists
		object.artists
	end

	def geocode
		HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{ object.full_address }&key=#{ Rails.application.secrets.google_api }", :verify => false)
	end

	def location
		object.location
	end
end