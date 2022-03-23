class SessionsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def create
        user = User.find_by!(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: ["Invalid username or password"]}, status: :unauthorized
        end
    end

    private

    def not_found(error)
        render json: {error: "#{error.model} not found"}, status: 401
    end

end
