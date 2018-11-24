class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]



  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: '¡Post creado satisfactoriamente!'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: '¡Post actualizado satisfactoriamente!'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private

def owned_post  
  unless current_user == @post.user
    flash[:alert] = "¡Este post no te pertenece!"
    redirect_to root_path
  end
end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_path, notice: "¡No estás autorizada/o para editar este post!" if @post.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
     params.require(:post).permit(:description, :image)
    end
end