class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tags, except: [:create, :update, :destroy, :toggle_active]

  def index
    @bookmark = current_user.bookmarks.build 
    if params[:tag].present?
      @bookmarks = current_user.bookmarks.tagged_with(params[:tag])
    else
      @bookmarks = current_user.bookmarks.where(active: true).last(10)
    end
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

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update(bookmark_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_to bookmarks_path
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
    @bookmarks = Bookmark.where(active: true).joins(:like).where(likes: {user_id: current_user.id }).last(10)
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

  def search
    @q = params['q']
    return if @q.blank?
    @hits = current_user.bookmarks.algolia_search(@q)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:link, :tag_list, :viewable_by, :active)
  end

  def set_tags
    @tags =  current_user.owned_tags.most_used(10)
  end
end
