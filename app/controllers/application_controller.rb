class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @documents = api.form("everything").submit(ref: 'master')
  end

  def api
    @api ||= Prismic.api("http://lesbonneschoses.wroom.io/api")
  end

end
