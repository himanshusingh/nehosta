module SpacesHelper
	def bedroom_options
		1..15
	end

	def bathroom_options
		1..10
	end

	def room_types
		['Private room','Shared room','Entire space']
	end

	def amenities_options
		['Internet', 'TV', 'Breakfast', 'Dinner', 'Air Conditioning', 'Smoking Allowed', 'Kitchen', 'Heating']
	end
end
