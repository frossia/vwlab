class PostsController < ApplicationController

  def index
    @posts = Post.where(:published => true)
    @catalogs_all = Catalog.all
  end

  def show
    @post = Post.find(params[:id])
    @catalogs_all = Catalog.all
  end

end
