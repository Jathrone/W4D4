class UsersController < ApplicationController
    before_action :require_log_out, only: [:new, :create]

    def new
        render :new
    end

    def create
        user = User.new(user_params)
        if user.save
            self.log_in_user!(user)
            redirect_to user_url(user)
            #change later
        else
            flash.now[:errors] = user.errors.full_messages
            render :new
        end
    end
    
    def show
        @user = User.find(params[:id])
        render :show
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
