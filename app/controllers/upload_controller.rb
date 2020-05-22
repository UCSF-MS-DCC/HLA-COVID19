class UploadController < ApplicationController

    def index
        if !current_user
            redirect_to root_path
        end
        @user = current_user
    end

    def store 
        current_user.uploads.attach(upload_params[:attachments])
    end


end

    def upload_params
        params.require(:user).permit(attachments:[])
    end