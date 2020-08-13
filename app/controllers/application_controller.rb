class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from ActionController::RoutingError, with: -> { render_404 }

    def render_404
      respond_to do |format|
        format.html { render template: 'errors/not_found', status: :not_found }
        format.all { render nothing: true, status: :not_found }
      end
    end
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:affiliation, :request_rstudio_priv, :request_upload_priv, :project_owner, project_name: []])
      devise_parameter_sanitizer.permit(:account_update, keys: [:affiliation, :request_rstudio_priv, :request_upload_priv, :project_owner, project_name:[]])
    end
end
