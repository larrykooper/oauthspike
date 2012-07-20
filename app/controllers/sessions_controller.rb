class SessionsController < ApplicationController 
  
  def connect
    @client = Twitterauth::Client
    oauth_confirm_url = "http://#{request.host_with_port()}/sessions/callback"
    puts oauth_confirm_url
    request_token = @client.request_token(:oauth_callback => oauth_confirm_url)
    #:oauth_callback required for web apps, since oauth gem by default force PIN-based flow 
    #( see http://groups.google.com/group/twitter-development-talk/browse_thread/thread/472500cfe9e7cdb9/848f834227d3e64d )
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url    
  end
  
  def callback
    # Exchange the request token for an access token.
    @client = Twitterauth::Client
    @access_token = @client.authorize(
      session[:request_token],
      session[:request_token_secret],
      :oauth_verifier => params[:oauth_verifier]
    ) 
  
    if @client.authorized?
      # Storing the access tokens so we don't have to go back to Twitter again
      # in this session.  In a larger app you would probably persist these details somewhere.
      session[:access_token] = @access_token.token
      session[:secret_token] = @access_token.secret
      session[:user] = true
      redirect_to '/welcome/home'
    else
      redirect_to '/sessions/connect'
    end
  end 
  
  def signout
  end
  
end 

#  http://twitter.com/oauth/authorize?oauth_token=TOKEN
    
  