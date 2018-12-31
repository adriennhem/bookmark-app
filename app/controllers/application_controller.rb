class ApplicationController < ActionController::Base
	include Pundit
  	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
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


  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

    def set_tags
	  if user_signed_in? 
        @tags =  current_user.owned_tags.most_used(10)
	  end
	end
end
