class ApplicationController < ActionController::Base
    layout :layout_for_devise
	before_action :set_tags, if: :devise_controller?


	def after_sign_in_path_for(resource)
		bookmarks_path
	end

	def after_sign_out_path_for(resource)
		root_path
	end

	def layout_for_devise
	  if devise_controller? && action_name == "edit"
	  	"application"
	  elsif controller_name == "bookmarks"
	  	"application"
	  elsif devise_controller? && action_name == "new"
	  	"application"
	  else
	    "website"
	  end
  	end

    def set_tags
	  if user_signed_in? 
        @tags =  current_user.owned_tags.most_used(10)
	  end
	end
end
