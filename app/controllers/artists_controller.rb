class ArtistsController < ApplicationController
	def index
		@artists = Artist.all
	end

	def new
		@artist = Artist.new
	end

	def create
		@artist = Artist.new(artist_params)

		respond_to do |format|
		    if @artist.save
		        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
		        format.json { render :show, status: :created, location: @artist }
		    else
		        format.html { render :new }
		        format.json { render json: @artist.errors, status: :unprocessable_entity }
		    end
		end
	end

	def show
		@artist = Artist.find(params[:id])
	end

	def edit
		@artist = Artist.find(params[:id])
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
	    @artist.destroy
	    respond_to do |format|
	    	format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
	    	format.json { head :no_content }
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
