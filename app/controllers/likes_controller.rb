class LikesController < ApplicationController
  def create
  	bookmark = Bookmark.find(params[:bookmark_id])
  	@like = current_user.likes.build
  	@like.bookmark_id = bookmark.id
  	@like.save 
  	flash[:notice] = "Liked Successfully!"
  	redirect_to bookmarks_path
  end

  def destroy
  end
end
