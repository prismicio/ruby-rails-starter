module PrismicHelper

  class LinkResolver
    include PrismicHelper
    attr_reader :ref
    def initialize(ref, &blk)
      @ref = ref
      @blk = blk
    end
    def link_to(doc_link)
      @blk.call(id: doc_link.id, slug: doc_link.slug, ref: ref)
    end
  end

  def url_to_doc(doc, ref)
    document_path(id: doc.id, slug: doc.slug, ref: ref)
  end
  def link_to_doc(doc, ref, html_options={}, &blk)
    link_to(url_to_doc(doc, ref), html_options, &blk)
  end

  def display_doc(doc, ref)
    doc.as_html(link_resolver(ref)).html_safe
  end

  def link_resolver(ref)
    LinkResolver.new(ref){|args| document_path(args) }
  end

end
