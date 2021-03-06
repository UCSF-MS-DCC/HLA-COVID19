class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_paper_trail_whodunnit
    rescue_from ActionController::RoutingError, with: -> { render_404 }

    def render_404
      respond_to do |format|
        format.html { render template: 'errors/not_found', status: :not_found }
        format.all { render nothing: true, status: :not_found }
      end
    end
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :affiliation, :request_rstudio_priv, :request_upload_priv, :email_opt_in, :project_owner, project_name: []])
      devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :affiliation, :request_rstudio_priv, :request_upload_priv, :email_opt_in, :project_owner, :project_name =>[]])
    end
end
