module ParlorsHelper
	def fetch_parlors
		parlors = $redis.get("parlors")

		if parlors.nil?
			parlors = Parlor.all.to_json({:methods => :full_address})
			$redis.set("parlors", parlors)
			$redis.expire("parlors", 5.hour.to_i)
		end
		
		@parlors = JSON.load parlors
	end
end
