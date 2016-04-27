class ArtistsController < ApplicationController
	require 'json'

	def index
		json_artists = Artist.all.to_json({:methods => :image, :include => { :parlor => {:methods => :full_address}}})
		@artists = JSON.parse(json_artists)
		json_parlors = Parlor.all.to_json({:include => :pictures, :methods => :full_address})
		@parlors = JSON.parse(json_parlors)
	end

	def create
		@artist = Artist.new(artist_params)

	    if @artist.save
	        render json: @artist
	    else
	        render json: @artist.errors, status: :unprocessable_entity
	    end
	end

	def show
		json_artist = Artist.find(params[:id]).to_json({:methods => :image_name, :include => {:parlor => {:methods => :full_address}}})
		@artist = JSON.parse(json_artist)
	end

	def update
		@artist = Artist.find(params[:id])
	    if @artist.update(artist_params)
	        render json: @artist
	    else
	        render json: @artist.errors, status: :unprocessable_entity
	    end
	end

	def destroy
		@artist = Artist.find(params[:id])
	    @artist.destroy
	    head :no_content
	end

	private
	def set_artist
		@artist = Artist.find(params[:id])
	end

	def artist_params
		params.require(:artist).permit(:id, :parlor_id, :first_name, :last_name, :picture, parlors_attributes: [:name, :street_number, :street_direction, :street_name, :street_type, :unit, :city, :state, :zip], pictures_attributes: [:image, :content_type, :original_filename, :image_data])
	end
end
