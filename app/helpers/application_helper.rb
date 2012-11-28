module ApplicationHelper
	def fb_connected?(user)
		if user.fb_url.nil?
			false
		else
			true
		end
	end

	def full_title(page_title)
		base_title = "Kumbh"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
end
