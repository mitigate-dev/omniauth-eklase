require "omniauth-oauth2"
require "omniauth-eklase/version"
require "omniauth-eklase/form_mime_type_fix_middleware"

module OmniAuth
  module Strategies
    class Eklase < OmniAuth::Strategies::OAuth2
      option :name, "eklase"

      option :client_options,
        site: "https://login.e-klase.lv",
        authorize_url: '/Auth/OAuth/',
        token_url:     '/Auth/OAuth/GetAccessToken/',
        token_method:  :get

      uid { info["id"] }

      info do
        raw_info["Person"].inject({}) do |h, (k, v)|
          h[underscore(k)] = v
          h
        end
      end

      extra do
        { raw_info: raw_info }
      end

      # Log everything.
      # Fix content-type for query string responses.
      def client
        super.tap do |c|
          c.connection.response :logger, OmniAuth.logger
          c.connection.use OmniAuth::Eklase::FormMimeTypeFixMiddleware
        end
      end

      # The callback should match the redirect_uri that was passed
      # in request phase, so ?code=:code must be removed.
      def callback_url
        full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||= begin
          response = access_token.get("/Auth/OAuth/API/Me?access_token=#{access_token.token}")
          MultiXml.parse(response.body)
        end
      end

      private

      def underscore(str)
        str.
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
      end
    end
  end
end
