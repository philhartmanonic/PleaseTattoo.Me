class PicturesController < ApplicationController
	def create
		if params["picture"]["imageable_type"] == "Artist"
			@artist = Artist.find(params["picture"]["imageable_id"])
			@artist.picture = Picture.new(picture_params)
		end

		if @artist.picture.save
			render json: @picture
		else
			render json: @picture.errors, status: :unprocessable_entity
		end
	end

	private

	def parent
		Artist.find params[:artist_id] if params[:artist_id]
		Parlor.find params[:parlor_id] if params[:parlor_id]
		Tat.find params[:tat_id] if params[:tat_id]
	end

	def picture_params
		params.require(:picture).permit(:image, :artist_id, :parlor_id, :tat_id, :imageable_id, :imageable_type, :image_file_name)
	end
end