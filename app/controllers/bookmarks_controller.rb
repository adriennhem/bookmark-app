class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks.where(active: true).last(10)
    @bookmark = current_user.bookmarks.build 
  end


  def new
  end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    respond_to do |format|
    if @bookmark.save 
      flash[:notice] = "Successfully Saved"
      format.html { redirect_to bookmarks_path, notice: 'Bookmark was successfully created.' }
      format.json { render :create, status: :created }
    else
      flash[:error] = "Something went wrong..."
      redirect_to request.referrer
    end
    end
  end

  def update
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy 
    respond_to do |format|
      format.html { redirect_to bookmarks_path, notice: 'Bookmark was successfully destroyed.' }
      format.json { render :destroy, status: :no_content }
    end
  end

  def show
  end

  def liked
    @bookmark = current_user.bookmarks.build 
    @bookmarks = Bookmark.joins(:likes).where(likes: {user_id: current_user.id }).last(10)
  end

  def archived
    @bookmark = current_user.bookmarks.build 
    @bookmarks = current_user.bookmarks.where(active: false).last(10)
  end

  def toggle_active
    @bookmark = Bookmark.find(params[:id])
    @bookmark.update(active: !@bookmark.active?)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { render :toggle_active, status: :no_content }
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:link)
  end
end
