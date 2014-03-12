class SocialController < ApplicationController
  def index
    @instagram_draperu = Instagram.tag_recent_media('draperu', options = {count: 20})
    @instagram_draperuonline = Instagram.tag_recent_media('draperuonline', options = {count: 20})
    @instagram_draperfall = Instagram.tag_recent_media('dufall2013', options = {count: 20})
  end
end
