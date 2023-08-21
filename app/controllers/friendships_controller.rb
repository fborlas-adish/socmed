class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def index
        @filter = params[:filter]
        
        @user = current_user

        if @filter == "requests"
            @friendships = Friendship.where(friend: @user, friendship_status: "pending")
        end
    end

    def new
        @friendship = Friendship.new
    end

    def create
        @friendship = Friendship.new(user: User.find(params[:friendship][:user]), friend: User.find(params[:friendship][:friend]), friendship_status: "pending" )

        if @friendship.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
        def friendship_params
            params.require(:friendship).permit(:user, :friend, :friendship_status)
        end
end
