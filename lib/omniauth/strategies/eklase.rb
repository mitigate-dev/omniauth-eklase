require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Eklase < OmniAuth::Strategies::OAuth2
      option :name, "eklase"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options,
        site: "https://login.e-klase.lv",
        authorize_url: '/Auth/OAuth/',
        token_url:     '/Auth/OAuth/GetAccessToken/'

      uid { request.params['user_id'] }

      # info do
      #   {
      #     :name => raw_info['name'],
      #     :location => raw_info['city']
      #   }
      # end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.
          get("/Auth/OAuth/API/Me?access_token=#{access_token}")
      end
    end
  end
end
