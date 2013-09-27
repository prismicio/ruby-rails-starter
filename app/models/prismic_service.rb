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

  end
end
