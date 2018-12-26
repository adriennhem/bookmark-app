class LikesController < ApplicationController

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
  	@like = current_user.likes.build
  	@like.bookmark_id = @bookmark.id
  	@like.save 
  	redirect_to request.referrer
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to request.referrer
  end
end
