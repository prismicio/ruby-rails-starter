class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @ref = api.ref_id_by_label('Master')
    @documents = api.form("everything").submit(@ref.ref)
  end

  def api
    @api ||= Prismic.api("http://lesbonneschoses.prismic.io/api")
  end

end
