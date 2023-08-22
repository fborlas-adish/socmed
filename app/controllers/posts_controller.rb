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

        unless @post.can_update?(@post.user)
            flash.now[:alert] = "Unable to update Post"
            return render :edit, status: :unprocessable_entity
        end

        if @post.update(post_params)
            redirect_to user_post_path(@post.user, @post)
        else
            flash.now[:alert] = "Unable to update Post"
            render :edit, status: :unprocessable_entity
        end
    end

    def create
        @user = current_user

        @post = @user.posts.create(post_params)

        if @post["id"]
            redirect_to user_posts_path(@user)
        else
            flash.now[:alert] = "Unable to create Post"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @user = current_user
        @post = @user.posts.find(params[:id])

        unless @post.can_update?(@user)
            flash.now[:alert] = "Unable to delete Post"
            return render :index, status: :unprocessable_entity
        end

        @post.destroy
        redirect_to user_posts_path(@user), status: :see_other
    end

    private
        def post_params
            params.require(:post).permit(:body, media: [])
        end
end
