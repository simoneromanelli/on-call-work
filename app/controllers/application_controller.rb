class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken

  after_action :verify_authorized

  def authorize_class(klass)
    authorize klass
  end

  def authorize_instace(instace)
    authorize instace
  end
end
