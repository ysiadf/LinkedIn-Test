class LinkedinController < ApplicationController
  def home
    client = LinkedIn::Client.new('JNKdJz__UAKhEXnJbZXETwZ7UnwUg-RrutK4ky614kkNBk5eVw40zJqOGh392tY1', 
                                  'm4Lqz8tTlzRqfsIuwpq9ULySpRaMWDMISKdQ6TGoRIPDlnTcK1AEFi9C5qHXxyPA')
    rtoken = client.request_token.token
    rsecret = client.request_token.secret
    authorize_url = client.request_token.authorize_url
    redirect_to authorize_url
  end

  def callback
    client = LinkedIn::Client.new('JNKdJz__UAKhEXnJbZXETwZ7UnwUg-RrutK4ky614kkNBk5eVw40zJqOGh392tY1', 
                                  'm4Lqz8tTlzRqfsIuwpq9ULySpRaMWDMISKdQ6TGoRIPDlnTcK1AEFi9C5qHXxyPA')
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret],pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @profile = client.profile
    @connections = client.connections
  end
end
