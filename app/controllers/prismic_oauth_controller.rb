# The necessary actions to have prismic.io OAuth2 connection working.
# This allows to access to the master ref on private APIs, and to access to the future content releases.
# If you need to change your client id and client secret, it happens in the config/prismic.yml file.
class PrismicOauthController < ApplicationController
	
  def get_callback_url
    callback_url(redirect_uri: request.env['referer'])
  end

  def signin
    url = PrismicService.oauth_initiate_url(access_token,
      client_id: PrismicService.config("client_id"),
      redirect_uri: get_callback_url,
      scope: "master+releases"
    )
    redirect_to url
  end

  def callback
    token = PrismicService.oauth_check_token(access_token,
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: get_callback_url,
      client_id: PrismicService.config("client_id"),
      client_secret: PrismicService.config("client_secret"),
    )
    if token
      session['ACCESS_TOKEN'] = token
      url = params['redirect_uri'] || root_path
      redirect_to url
    else
      render "Can't sign you in", status: :unauthorized
    end
  end

  def signout
    session['ACCESS_TOKEN'] = nil
    redirect_to :root
  end

end
