class ArtistsController < ApplicationController
	require 'json'
	include ArtistsHelper
	include ParlorsHelper

	def index
		fetch_artists
		fetch_parlors
	end

	def create
		@artist = Artist.new(artist_params)

	    if @artist.save
	        render json: @artist
	        $redis.set("artists", Artist.all.to_json({:include => {:parlor => {:methods => :full_address}}}))
	        $redis.expire("artists", 5.hours.to_i)
	    else
	        render json: @artist.errors, status: :unprocessable_entity
	    end
	end

	def update
		respond_to do |format|
		    if @Artist.update(artist_params)
		        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
		        format.json { render :show, status: :ok, location: @artist }
		    else
		        format.html { render :edit }
		        format.json { render json: @artist.errors, status: :unprocessable_entity }
		    end
	    end
	end

	def destroy
		@artist = Artist.find(params[:id])
	    @artist.destroy
	    respond_to do |format|
	    	format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
	    	format.json { head :no_content }
	    $redis.set("artists", Artist.all.to_json({:include => {:parlor => {:methods => :full_address}}}))
	    end
	end

	private
	def set_artist
		@artist = Artist.find(params[:id])
	end

	def artist_params
		params.require(:artist).permit(:id, :parlor_id, :first_name, :last_name, parlors_attributes: [:name, :street_number, :street_direction, :street_name, :street_type, :unit, :city, :state, :zip])
	end
end
