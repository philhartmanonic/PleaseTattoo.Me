module ArtistsHelper
	def fetch_artists
		artists = $redis.get("artists")
		if artists.nil?
			artists = Artist.all.to_json({:include => { :parlor => { :methods => :full_address }}})
			$redis.set("artists", artists)
			$redis.expire("artists", 5.hour.to_i)
		end
		@artists = JSON.load artists
	end

end
