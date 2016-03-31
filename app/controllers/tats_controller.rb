class TatsController < ApplicationController
	def index
		@tats = Tat.all
	end

	def new
		@tat = Tat.new
	end

	def create
		@tat = Tat.new(tat_params)

		respond_to do |format|
		    if @tat.save
		        format.html { redirect_to @tat, notice: 'Tat was successfully created.' }
		        format.json { render :show, status: :created, location: @tat }
		    else
		        format.html { render :new }
		        format.json { render json: @tat.errors, status: :unprocessable_entity }
		    end
		end
	end

	def show
		@tat = Tat.find(params[:id])
	end

	def edit
		@tat = Tat.find(params[:id])
	end

	def update
		respond_to do |format|
		    if @tat.update(tat_params)
		        format.html { redirect_to @tat, notice: 'Tat was successfully updated.' }
		        format.json { render :show, status: :ok, location: @tat }
		    else
		        format.html { render :edit }
		        format.json { render json: @tat.errors, status: :unprocessable_entity }
		    end
	    end
	end

	def destroy
	    @tat.destroy
	    respond_to do |format|
	    	format.html { redirect_to tats_url, notice: 'Tat was successfully destroyed.' }
	    	format.json { head :no_content }
	    end
	end

	private
	def set_tat
		@tat = Tat.find(params[:id])
	end

	def tat_params
		params.require(:tat).permit(:id, :artist_id)
	end
end
