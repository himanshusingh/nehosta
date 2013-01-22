module ApplicationHelper
	def fb_connected?(user)
		if user.fb_url.nil?
			false
		else
			true
		end
	end

	def full_title(page_title)
		base_title = "Nehosta"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def signed_in_user
		unless user_signed_in?
			redirect_to new_user_session_path, notice: "Please sign-in first to view this page."
		end
	end

	def admin_user
		redirect_to root_path unless current_user.try(:admin?) || (current_user.id == 1)
	end

	# Devise resource name fix
	def resource_name
	  :user
	end

	def resource
	  @resource ||= User.new
	end

	def devise_mapping
	  @devise_mapping ||= Devise.mappings[:user]
	end
end
