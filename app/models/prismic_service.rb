include Rails.application.routes.url_helpers

module PrismicService
  class << self
    def get_document(id, api, ref)
      documents = api.form("everything")
      .query("[[:d = at(document.id, \"#{id}\")]]")
      .submit(ref)

      documents.empty? ? nil : documents.first
    end

    def init_api
      Prismic.api("https://lesbonneschoses.prismic.io/api")
    end

    def link_resolver(document_id, document_slug, ref = nil)
      url_helper = Rails.application.routes.named_routes.helpers
      url_helper.document_path(:id => document_id, :slug => document_slug, :ref => ref)
    end
  end
end
