class UploadController < ApplicationController

    def index
        if !current_user
            redirect_to root_path
        end
        @user = current_user
    end

    def store 
        unless upload_params[:irb_sharing_approved] == false
            current_user.uploads.attach(upload_params[:attachments])
        end
    end

end

    def upload_params
        params.require(:user).permit(:irb_sharing_approved, attachments:[])
    end