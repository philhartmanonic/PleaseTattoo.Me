class Api::V1::ParlorsController < Api::V1::BaseController
	def show
		parlor = Parlor.find(params[:id])

		render(json: Api::V1::ParlorSerializer.new(parlor).to_json({:methods => :full_address}))
	end
end