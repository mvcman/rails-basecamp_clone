class UsersController < ApplicationController
    def index 
        @users = User.includes(:profile).all.search(params)
        render json: @users.to_json(include: :profile)
    end

    def selected_users
        users = params[:ids].split(",")
        @users = User.includes(:profile).where(id: users)
        render json: @users.to_json(include: :profile)
    end 
end 