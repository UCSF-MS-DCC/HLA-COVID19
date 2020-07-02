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
            current_user.upload_filename_check
        end
        # current_user.uploads.each do |u|
        #     puts "FILE: #{u.filename}"
        # end
        redirect_to action: "index"
    end

end

    def upload_params
        params.require(:user).permit(:irb_sharing_approved, attachments:[])
    end