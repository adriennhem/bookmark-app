class BookmarksController < ApplicationController
  require 'will_paginate/array'
  # before_action :authenticate_user!
  before_action :set_tags, only: [:index, :liked, :archived, :search, :edit]


  def index

    @bookmark = current_user.bookmarks.build 
    if params[:tag].present?
      @bookmarks = current_user.bookmarks.tagged_with(params[:tag]).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    else
      @bookmarks = current_user.bookmarks.where(active: true).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    end
  end

  def show
  end


  def new
  end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    current_user.tag(@bookmark, :with => params[:bookmark][:tag_list], :on => :tags) 
    @bookmark.tag_bookmark =  params[:bookmark][:tag_list]
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
    authorize @bookmark
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if params[:bookmark][:tag_bookmark] != nil 
      current_user.tag(@bookmark, :with => params[:bookmark][:tag_bookmark], :on => :tags) 
      @bookmark.tag_list =  params[:bookmark][:tag_bookmark]
      @bookmark.tag_bookmark = params[:bookmark][:tag_bookmark]
    end
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
      format.html { redirect_to request.referrer, notice: 'Bookmark was successfully destroyed.' }
      format.json { render :destroy, status: :no_content }
    end
  end

  def liked
    @bookmark = current_user.bookmarks.build 
    @bookmarks = Bookmark.where(active: true).joins(:like).where(likes: {user_id: current_user.id }).order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def archived
    @bookmark = current_user.bookmarks.build 
    @bookmarks = current_user.bookmarks.where(active: false).order('created_at DESC').paginate(page: params[:page], per_page: 10)
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
    @hits = current_user.bookmarks.search(@q)
  end

  def duplicates
    # @bookmarks = current_user.bookmarks.where(active: true).group(:link).having("count(link) > 1")
    columns_that_make_record_distinct = [:link]
    distinct_ids = current_user.bookmarks.select("MIN(id) as id").group(:link).map(&:id)
    @duplicate_records = current_user.bookmarks.where.not(id: distinct_ids)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:link, :tag_list, :viewable_by, :active, :title, :thumbnail, :description, :tag_bookmark)
  end

  def set_tags
    @tags =  current_user.owned_tags.most_used(10)
  end
end
