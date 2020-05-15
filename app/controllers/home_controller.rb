class HomeController < ApplicationController
    def index
        if current_user
            @user = current_user
        else
            @user = User.new
        end
    end
    def auth
        unless current_user
            @user = User.new
        end
    end
    def account
    end
end
