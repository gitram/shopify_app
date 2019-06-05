module ShopifyApp
  module SessionStorage
    class ShopStorageStrategy

      def self.store(session)
        shop = Shop.find_or_initialize_by(shopify_domain: session.domain)
        shop.shopify_token = session.token
        shop.save!
        shop.id
      end

      def self.retrieve(id)
        return unless id
        if shop = Shop.find_by(id: id)
          ShopifyAPI::Session.new(
            domain: shop.shopify_domain,
            token: shop.shopify_token,
            api_version: shop.api_version
          )
        end
      end
    end
  end
end
