module Authifer
  module OAuthHelper
    def resource_owner
      @resource_owner ||= current_user.persisted? ? current_user : :implicit
    end

    def oauth2
      @oauth2 ||= Songkick::OAuth2::Provider.parse(resource_owner, env)
    end

    def handle_oauth
      if oauth2.redirect?
        redirect oauth2.redirect_uri, oauth2.response_status
      end

      headers oauth2.response_headers
      status  oauth2.response_status

      if body = oauth2.response_body
        body
      elsif oauth2.valid?
        erb :authorize, locals: { authorization_request: oauth2 }
      else
        raise "Error Will Robinson"
      end
    end
  end
end
