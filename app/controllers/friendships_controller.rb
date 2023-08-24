class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def index
        @filter = params[:filter]
        
        @user = current_user

        if @filter == "accepted"
            @friendships = Friendship.where('friendship_status = ? AND (user_id = ? OR friend_id = ?)', "accepted", @user.id, @user.id)
        end

        if @filter == "pending"
            @friendships = Friendship.where(user: @user, friendship_status: "pending")
        end 

        if @filter == "requests"
            @friendships = Friendship.where(friend: @user, friendship_status: "pending")
        end
    end

    def create
        puts "test"

        if friends?
            flash[:alert] = "Friends or request has been sent already"
            redirect_to(user_friendships_path(current_user, filter: :accepted)) && return
        end

        @friendship = Friendship.new(user: User.find(params[:friendship][:user]), friend: User.find(params[:friendship][:friend]), friendship_status: "pending" )

        if @friendship.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        @requester = User.find(params[:id])
        @user = User.find(params[:user_id])

        @pending_friendship = @requester.friendships.find_by(friend: @user, friendship_status: "pending");

        if @pending_friendship.update(friendship_status: params[:accept] ? "accepted" : "declined")
            redirect_to root_path
        else
            render :index, status: :unprocessable_entity
        end
    end

    private
        def friendship_params
            params.require(:friendship).permit(:user, :friend, :friendship_status)
        end

        def friends?
            friendships = Friendship.where('user_id = ? OR friend_id = ?', params[:friendship][:user], params[:friendship][:user])

            friendships.each do | friendship |
                if friendship.friend_id == params[:friendship][:friend].to_i || friendship.user_id == params[:friendship][:friend].to_i
                    return true
                end
            end

            return false
        end
end
