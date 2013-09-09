class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_ref

  def index
    begin
      @documents = api.form("everything").submit(@ref)
    rescue Prismic::SearchForm::RefNotFoundException => e
      render inline: e.message, :status => :not_found
    end
  end

  def api
    @api ||= Prismic.api("https://lesbonneschoses.prismic.io/api")
  end

  private

  def set_ref
    @ref = params[:ref] || api.ref_id_by_label('Master').ref
  end
end
