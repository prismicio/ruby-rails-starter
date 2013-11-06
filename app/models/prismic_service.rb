module PrismicService
  class << self

    def config(key=nil)
      @config ||= YAML.load_file(Rails.root + "config" + "prismic.yml")
      key ? @config.fetch(key) : @config
    end

    def get_document(id, api, ref)
      documents = api.create_search_form("everything")
                     .query("[[:d = at(document.id, \"#{id}\")]]")
                     .submit(ref)

      documents.empty? ? nil : documents.first
    end

    def access_token
      config['token']
    end

    def init_api(access_token)
      access_token ||= self.access_token
      Prismic.api(config('url'), access_token)
    end

  end
end
