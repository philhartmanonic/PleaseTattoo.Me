class Api::V1::ArtistsController < Api::V1::BaseController
	def show
		artist = Artist.find(params[:id])

		render(json: Api::V1::ArtistSerializer.new(artist).to_json({:include => {:picture => {}, :parlor => { :methods => :full_address }}}))
	end
end