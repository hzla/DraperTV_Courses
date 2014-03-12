require "instagram"

Instagram.configure do |config|
  config.client_id = "b9682b36cad648a99aa9f0bfd1934293"
  config.client_secret = "15a9648d598b43bf91c065f15c8283d3"
end

# get "/" do
#   '<a href="/oauth/connect">Connect with Instagram</a>'
# end

# get "/oauth/connect" do
#   redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
# end

# get "/oauth/callback" do
#   response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
#   session[:access_token] = response.access_token
#   redirect "/feed"
# end

# get "/feed" do
#   client = Instagram.client(:access_token => session[:access_token])
#   user = client.user

#   html = "<h1>#{user.username}'s recent photos</h1>"
#   for media_item in client.user_recent_media
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html
# end