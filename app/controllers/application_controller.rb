class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_ref

  def index
    begin
      @documents = api.form("everything").submit(@ref)
    rescue Prismic::SearchForm::RefNotFoundException => e
      render inline: e.message, status: :not_found
    end
  end

  def document
    id = params[:id]
    slug = params[:slug]

    @document = PrismicService.get_document(id, api, @ref)
    if @document.nil?
      render inline: "Document not found", status: :not_found
    elsif slug == @document.slug
      @document
    elsif document.slugs.contains(slug)
      redirect_to document_application_path(id, slug), status: :moved_permanently
    else
      render inline: "Document not found", status: :not_found
    end
  end

  def search
    @documents = api.form("everything").query(%([[:d = fulltext(document, "#{params[:q]}")]])).submit(@ref)
  end

  def get_callback_url
    callback_url(redirect_uri: request.env['referer'])
  end

  def signin
    url = api.oauth_initiate_url({
      client_id: PrismicService.config("client_id"),
      redirect_uri: get_callback_url,
      scope: "master+releases"
    })
    redirect_to url
  end

  def callback
    access_token = api.oauth_check_token({
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: get_callback_url,
      client_id: PrismicService.config("client_id"),
      client_secret: PrismicService.config("client_secret"),
    })
    if access_token
      session['ACCESS_TOKEN'] = access_token
      url = params['redirect_uri'] || root_path
      redirect_to url
    else
      render "Can't sign you in", status: :unauthorized
    end
  end

  def signout
    session['ACCESS_TOKEN'] = nil
    redirect_to :root
  end

  private

  def set_ref
    @ref = params[:ref].blank? ? api.master_ref.ref : params[:ref]
  end

  def api
    @access_token = session['ACCESS_TOKEN']
    @api ||= PrismicService.init_api(@access_token)
  end

end
