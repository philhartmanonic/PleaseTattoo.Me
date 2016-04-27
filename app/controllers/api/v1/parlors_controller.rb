class Api::V1::ParlorsController < Api::V1::BaseController
	include ActiveHashRelation

	def index
		parlors = Parlor.all

		render(
			json: ActiveModel::ArraySerializer.new(
				parlors,
				each_serializer: Api::V1::ParlorSerializer,
				root: 'parlors',
			)
		).to_json({:include => :pictures, :methods => [:full_address, :location]})
	end
	def show
		parlor = Parlor.find(params[:id])

		render(json: Api::V1::ParlorSerializer.new(parlor).to_json({:include => :pictures, :methods => [:full_address, :location] }))
	end
end