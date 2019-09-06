module ShopifyApp
  module Utils

    def self.sanitize_shop_domain(shop_domain)
      name = shop_domain.to_s.downcase.strip
      name += ".#{ShopifyApp.configuration.myshopify_domain}" if !name.include?("#{ShopifyApp.configuration.myshopify_domain}") && !name.include?(".")
      name.sub!(%r|https?://|, '')

      u = URI("http://#{name}")
      u.host if u.host&.match(/^[a-z0-9][a-z0-9\-]*[a-z0-9]\.#{Regexp.escape(ShopifyApp.configuration.myshopify_domain)}$/)
    rescue URI::InvalidURIError
      nil
    end

    def self.fetch_known_api_versions
      fetching_msg = "[ShopifyAPI::ApiVersion] Fetching known Admin API Versions from Shopify..."
      Rails.logger.info(fetching_msg)
      puts fetching_msg
      ShopifyAPI::ApiVersion.fetch_known_versions

      known_versions_msg = "[ShopifyAPI::ApiVersion] Known API Versions: #{ShopifyAPI::ApiVersion.versions.keys}"
      Rails.logger.info(known_versions_msg)
      puts known_versions_msg

      rescue ActiveResource::ConnectionError
        error_msg = "[ShopifyAPI::ApiVersion] Unable to fetch api_versions from Shopify"
        logger.error(error_msg)
        puts error_msg
    end
  end
end
