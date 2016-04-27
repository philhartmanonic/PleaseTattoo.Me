class ParlorsController < ApplicationController
	require 'json'
	
	def search
		Parlor.reindex
		if params[:search].present?
			if params[:where].present? and params[:miles].present?
				address = params[:where].tr(',', '').tr(' ', '+')
				starter = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{ address }&key=#{ Rails.application.secrets.google_api }", :verify => false)
				begin
					location = starter["results"][0]["geometry"]["bounds"]
					lat = (location["northeast"]["lat"] + location["southwest"]["lat"]) / 2
					long = (location["northeast"]["lng"] + location["southwest"]["lng"]) / 2
				rescue
					location = starter["results"][0]["geometry"]["location"]
					lat = location["lat"]
					long = location["lng"]
				end
				parlors = Parlor.search(params[:search], where: {location: {near: [lat, long], within: params[:miles][0]}}, limit: 1000)
				json_parlors = parlors.to_json({:include => [:pictures, :artists => {:methods => :image}], :methods => [:full_address, :location]})
				@parlors = JSON.parse(json_parlors)
			else
				parlors = Parlor.search(params[:search], limit: 1000)
				json_parlors = parlors.to_json({:include => [:pictures, :artists => {:methods => :image}], :methods => [:full_address, :location]})
				@parlors = JSON.parse(json_parlors)
			end
		elsif params[:where].present? and params[:miles].present?
			address = params[:where].tr(',', '').tr(' ','+')
			starter = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{ address }&key=#{ Rails.application.secrets.google_api }", :verify => false)
			begin
				location = starter["results"][0]["geometry"]["bounds"]
				lat = (location["northeast"]["lat"] + location["southwest"]["lat"]) / 2
				long = (location["northeast"]["lng"] + location["southwest"]["lng"]) / 2
			rescue
				location = starter["results"][0]["geometry"]["location"]
				lat = location["lat"]
				long = location["lng"]
			end
			parlors = Parlor.search('*', where: {location: {near: [lat, long], within: params[:miles][0]}}, limit: 1000)
			json_parlors = parlors.to_json({:include => [:pictures, :artists => {:methods => :image}], :methods => [:full_address, :location]})
			@parlors = JSON.parse(json_parlors)
		else
			json_parlors = Parlor.all.to_json({:include => [:pictures, :artists => {:methods => :image}], :methods => [:full_address, :location]})
			@parlors = JSON.parse(json_parlors)
		end
	end

	def index
		json_parlors = Parlor.all.to_json({:include => [:pictures, :artists => {:methods => :image}], :methods => [:full_address, :location]})
		@parlors = JSON.parse(json_parlors)
	end

	def new
		@parlor = Parlor.new
	end

	def create
		@parlor = Parlor.new(parlor_params)

	    if @parlor.save
	        render json: @parlor
	    else
	        render json: @parlor.errors, status: :unprocessable_entity
	    end
	end

	def show
		@parlor = Parlor.find(params[:id]).to_json({:include => :pictures, :methods => :full_address})
		respond_to do |format|
			format.json { render :json => {:name => @parlor.name, :full_address => @parlor.full_address } }
		end
	end

	def edit
		@parlor = Parlor.find(params[:id])
	end

	def update
		respond_to do |format|
		    if @parlor.update(parlor_params)
		        format.html { redirect_to @parlor, notice: 'Parlor was successfully updated.' }
		        format.json { render :show, status: :ok, location: @parlor }
		    else
		        format.html { render :edit }
		        format.json { render json: @parlor.errors, status: :unprocessable_entity }
		    end
	    end
	end

	def destroy
	    @parlor.destroy
	    respond_to do |format|
	    	format.html { redirect_to parlors_url, notice: 'Parlor was successfully destroyed.' }
	    	format.json { head :no_content }
	    end
	end

	private
	def set_parlor
		@parlor = Parlor.find(params[:id])
	end

	def parlor_params
		params.require(:parlor).permit(:id, :name, :street_number, :street_direction, :street_name, :street_type, :unit, :city, :state, :zip, :full_address, pictures_attributes: [:image])
	end
end
