module OmniAuth
  module Eklase
    # Override the content-type of the response
    # with "application/x-www-form-urlencoded"
    # if the response body looks like it might be a query, e.g.
    #
    #   access_token=74e81934-2a6c-4b91-8e76-f9a616223ed9&expires=3600
    #
    class FormMimeTypeFixMiddleware < Faraday::Middleware
      CONTENT_TYPE = 'Content-Type'.freeze
      MIME_TYPE = 'application/x-www-form-urlencoded'.freeze
      QUERY_REGEX = /^(\&?[\w\_]+\=[\w\_\-]+)+$/

      def call(request_env)
        @app.call(request_env).on_complete do |response_env|
          if response_env[:body].to_s =~ QUERY_REGEX
            response_env[:response_headers][CONTENT_TYPE] = MIME_TYPE
          end
        end
      end
    end
  end
end