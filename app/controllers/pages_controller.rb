class PagesController < ApplicationController
  before_action :set_layout

  def home
  end

  private 

  def set_layout 
  	render layout: 'layouts/website'
  end
end
