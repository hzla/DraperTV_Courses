class VideosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @videos = Video.all
  end

  def show
    @video = Video.friendly.find(params[:id])
    @commentable = @video
    @comments = @commentable.user_comments.order(:created_at)
    @comment = UserComment.new

    if @video.vimeo_url
    oembed = "http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/" + @video.vimeo_url + '&maxwidth=660' + '&autoplay=1'
      puts (Curl::Easy.perform(oembed).body_str)["html"]
      @video_vimeo_embed = JSON.parse(Curl::Easy.perform(oembed).body_str)["html"]
    end

  end
end
