class HomeController < ApplicationController
	def home
		user_ip = request.location
		if user_ip.nil?
			pre_parlors = Parlor.all.sort_by{|t| -t.tats.size }[0..9]
		else
			pre_parlors = Parlor.search('*', boost_by_distance: {field: :location, origin: })
end
