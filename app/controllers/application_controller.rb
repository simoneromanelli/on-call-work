class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Serialization

  after_action :verify_authorized, unless: proc { |c| c.devise_controller? || c.controller_name=='errors' }

  def authorize_class(klass)
    authorize klass
  end

  def authorize_instace(instace)
    authorize instace
  rescue Pundit::NotAuthorizedError => e
    @policy_error = e.message.split('?').first
  end
end
