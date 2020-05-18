class UploadController < ApplicationController

    def index
        puts "HOME CONTROLLER"
        if !current_user
            redirect_to root_path
        end
        @user = current_user
    end

    def store 
        puts "STORE ACTION"
        puts params.to_json
        puts upload_params
        current_user.uploads.attach(upload_params[:attachments])
    end


end

    def upload_params
        params.require(:user).permit(attachments:[])
    end