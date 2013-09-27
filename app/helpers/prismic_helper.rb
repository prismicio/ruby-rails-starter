module PrismicHelper

  def url_to_doc(doc, ref)
    document_path(id: doc.id, slug: doc.slug, ref: ref)
  end
  def link_to_doc(doc, ref, html_options={}, &blk)
    link_to(url_to_doc(doc, ref), html_options, &blk)
  end

  def display_doc(doc)
    doc.as_html(nil).html_safe
  end

end
