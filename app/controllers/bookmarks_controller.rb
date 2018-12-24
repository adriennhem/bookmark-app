class BookmarksController < ApplicationController
  def new
  end

  def create
    @bookmark = Bookmark.create(bookmark_params)
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

  def index
    @bookmarks = Bookmark.all
    @bookmark = Bookmark.new 
  end

  def show
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:link)
  end
end
