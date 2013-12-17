module PrismicHelper

  # For a given document, describes its URL on your front-office.
  # You really should edit this method, so that it supports all the document types your users might link to.
  #
  # Beware: doc is not a Prismic::Document, but a Prismic::Fragments::DocumentLink,
  # containing only the information you already have without querying more (see DocumentLink documentation)
  def link_resolver(maybe_ref)
    @link_resolver ||= Prismic::LinkResolver.new(maybe_ref){|doc|
      document_path(id: doc.id, slug: doc.slug, ref: maybe_ref)
      # maybe_ref is not expected by document path, so it appends a ?ref=maybe_ref to the URL;
      # since maybe_ref is nil when on master ref, it appends nothing.
      # You should do the same for every path method used here in the link_resolver and elsewhere in your app,
      # so links propagate the ref id when you're previewing future content releases.
    }
  end

  # Checks if the user is connected to prismic.io's OAuth2.
  def connected?
    !!@access_token
  end

  # Checks if the user is connected or the app has an access token set for all users.
  def privileged_access?
    connected? || PrismicService.access_token
  end

  # Allows to call api directly in the view
  # (to check the bookmarks, for instance, you shouldn't query in the view!)
  def api
    @api
  end

end
