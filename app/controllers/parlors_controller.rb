class ParlorsController < ApplicationController
	def index
		@parlors = Parlor.all
	end

	def new
		@parlor = Parlor.new
	end

	def create
		@parlor = Parlor.new(parlor_params)

		respond_to do |format|
		    if @parlor.save
		        format.html { redirect_to @parlor, notice: 'Parlor was successfully created.' }
		        format.json { render :show, status: :created, location: @parlor }
		    else
		        format.html { render :new }
		        format.json { render json: @parlor.errors, status: :unprocessable_entity }
		    end
		end
	end

	def show
		@parlor = Parlor.find(params[:id])
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
		params.require(:parlor).permit(:id, :name, :street_number, :street_direction, :street_name, :street_type, :unit, :city, :state, :zip)
	end
end
