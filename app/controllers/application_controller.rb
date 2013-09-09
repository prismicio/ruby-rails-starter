class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_ref

  def index
    @documents = api.form("everything").submit(@ref)
  end

  def api
    @api ||= Prismic.api("https://lesbonneschoses.prismic.io/api")
  end

  private

  def set_ref
    @ref = params[:ref] || api.ref_id_by_label('Master').ref
  end
end
