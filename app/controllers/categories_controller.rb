require "#{Rails.root}/lib/assets/video_sharing_services_module"

class CategoriesController < ApplicationController
  def show
    @categories = Category.all

    @current_category = nil
    if request.path == '/'
      @current_category = @categories.first
    else
      requested_category_name = params[:id]
      @current_category = Category.where(name: requested_category_name).first
    end

    if @current_category.nil?
      render file: 'public/404.html'
      return
    end

    @feeds = VideoSharingServices::Youtube.get_feeds_via_db(@current_category.id)
  end
end