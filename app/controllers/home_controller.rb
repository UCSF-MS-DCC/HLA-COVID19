class HomeController < ApplicationController
    def index
        unless current_user
            @user = User.new
        end
    end
end
