class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = current_user
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @user = current_user
    end

    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])

        if @post.update(post_params)
            redirect_to user_post_path(@post.user, @post)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def create
        @user = current_user

        @post = @user.posts.create(post_params)

        puts @post.inspect

        if @post["id"]
            redirect_to user_posts_path(@user)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @user = current_user
        @post = @user.posts.find(params[:id])
        @post.destroy
        redirect_to user_posts_path(@user), status: :see_other
    end

    private
        def post_params
            params.require(:post).permit(:body)
        end
end
