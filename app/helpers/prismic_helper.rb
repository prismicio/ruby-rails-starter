module PrismicHelper

  def url_to_doc(doc, ref)
    document_path(id: doc.id, slug: doc.slug, ref: ref)
  end
  def link_to_doc(doc, ref, html_options={}, &blk)
    link_to(url_to_doc(doc, ref), html_options, &blk)
  end

  def display_doc(doc, ref)
    doc.as_html(link_resolver(ref)).html_safe
  end

  def link_resolver(maybe_ref)
    Prismic::LinkResolver.new(maybe_ref){|doc|
      document_path(id: doc.id, slug: doc.slug, ref: maybe_ref)
      # maybe_ref is not expected by document path, so it appends a ?ref=currentrefid to the URL;
      # since maybe_ref is nil when on master ref, it appends nothing.
      # You should do the same for every path method used in the link_resolver and elsewhere in your app,
      # so links propagate the ref id.
    }
  end

  def privileged_access?
    connected? || PrismicService.access_token
  end

  def connected?
    !!@access_token
  end

  def current_ref
    @ref
  end

  def master_ref
    @api.master_ref.ref
  end

  def api
    @api
  end

end
