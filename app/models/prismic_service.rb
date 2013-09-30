module PrismicService
  class << self

    def config
      pp Rails.root
      @config ||= YAML.load_file(Rails.root + "config" + "prismic.yml")
    end

    def get_document(id, api, ref)
      documents = api.form("everything")
      .query("[[:d = at(document.id, \"#{id}\")]]")
      .submit(ref)

      documents.empty? ? nil : documents.first
    end

    def init_api
      Prismic.api(config['url'])
    end

  end
end
