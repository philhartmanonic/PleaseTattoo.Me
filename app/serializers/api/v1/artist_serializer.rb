class Api::V1::ArtistSerializer < Api::V1::BaseSerializer
	attributes :id, :first_name, :last_name, :parlor_name, :parlor_address, :picture

	def parlor_name
		parlor = Parlor.find(object.parlor_id)
		parlor.name
	end

	def parlor_address
		parlor = Parlor.find(object.parlor_id)
		parlor.full_address
	end

	def image_name
		if object.picture.nil?
			'missing.png'
		else
			object.picture.image_file_name
		end
	end
end