module ApplicationHelper
	def fb_connected?(user)
		if user.fb_url.nil?
			false
		else
			true
		end
	end
end
