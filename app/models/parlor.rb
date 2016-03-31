class Parlor < ActiveRecord::Base
	has_many :artists
	has_many :tats, through: :artists

	def street_address
		return "#{self.street_number.to_s + ' ' if self.street_number.present?}#{self.street_direction + ' ' if self.street_direction.present?}#{self.street_name + ' ' if self.street_name.present?}#{self.street_type + ' ' if self.street_type.present?}#{'# ' + self.unit if self.unit.present?}".strip!
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
		return self.street_address + ', ' + self.city_and_state
	end
end
