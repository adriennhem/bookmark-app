class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tags, except: [:create, :update, :destroy, :toggle_active]

  def index
    @bookmarks = current_user.bookmarks.where(active: true).last(10)
    @bookmark = current_user.bookmarks.build 
  end

  def show
  end


  def new
  end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    current_user.tag(@bookmark, on: :tags, with: params[:bookmark][:tag_list])
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

  def liked
    @bookmark = current_user.bookmarks.build 
    @bookmarks = Bookmark.where(active: true).joins(:likes).where(likes: {user_id: current_user.id }).last(10)
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
    params.require(:bookmark).permit(:link, :tag_list)
  end

  def set_tags
    @tags =  current_user.owned_tags.most_used(10)
  end
end
