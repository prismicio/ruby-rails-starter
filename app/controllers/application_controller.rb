class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Rescue OAuth errors for some actions
  rescue_from Prismic::API::PrismicWSAuthError, with: :redirect_to_signin,
                                                only: [:index, :document, :search]

  # Homepage action: querying the "everything" form (all the documents, paginated by 20)
  def index
    @documents = api.form("everything")
                    .page(params[:page] ? params[:page] : "1")
                    .page_size(params[:page_size] ? params[:page_size] : "20")
                    .submit(ref)
  end

  # Single-document page action: mostly, setting the @document instance variable, and checking the URL
  def document
    id = params[:id]
    slug = params[:slug]

    @document = PrismicService.get_document(id, api, ref)

    # This is how an URL gets checked (with a clean redirect if the slug is one that used to be right, but has changed)
    # Of course, you can change slug_checker in prismic_service.rb, depending on your URL strategy.
    @slug_checker = PrismicService.slug_checker(@document, slug)
    if !@slug_checker[:correct]
      render inline: "Document not found", status: :not_found if !@slug_checker[:redirect]
      redirect_to document_path(id, @document.slug), status: :moved_permanently if @slug_checker[:redirect]
    end
  end

  # Search result: querying all documents containing the q parameter
  def search
    @documents = api.form("everything")
                    .query(%([[:d = fulltext(document, "#{params[:q]}")]]))
                    .page(params[:page] ? params[:page] : "1")
                    .page_size(params[:page_size] ? params[:page_size] : "20")
                    .submit(ref)
  end


  private


  def redirect_to_signin
    redirect_to signin_path
  end

  # Setting @ref as the actual ref id being queried, even if it's the master ref.
  # To be used to call the API, for instance: api.form('everything').submit(ref)
  def ref
    @ref ||= maybe_ref || api.master_ref.ref
  end

  # Setting @maybe_ref as the ref id being queried, or nil if it is the master ref.
  # To be used where you want nothing if on master, but something if on another release.
  # For instance:
  #  * you can use it to call Rails routes: document_path(ref: maybe_ref), which will add "?ref=refid" as a param, but only when needed.
  #  * you can pass it to your link_resolver method, which will use it accordingly.
  def maybe_ref
    @maybe_ref ||= (params[:ref].blank? ? nil : params[:ref])
  end

  ##

  # Easier access and initialization of the Prismic::API object.
  def api
    @api ||= PrismicService.init_api(access_token)
  rescue Prismic::API::PrismicWSAuthError => e
    reset_access_token!
    raise e
  end

  def access_token
    @access_token = session['ACCESS_TOKEN']
  end

  def reset_access_token!
    @access_token = session['ACCESS_TOKEN'] = nil
  end

end
