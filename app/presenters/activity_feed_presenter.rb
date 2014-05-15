class ActivityFeedPresenter < SimpleDelegator
  attr_reader :activity_feed

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def render_activity_feed
    render_partial
  end
  #link_to(activity.user.first_name, activity.user) + " " + render_partial


  def render_partial
    locals = {activity_feed: activity_feed, presenter: self}
    locals[activity_feed.trackable_type.underscore.to_sym] = activity_feed.trackable
    render partial_path, locals
  end

  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for activity in #{partial_paths}")
  end

  def partial_paths
    [
      "activitie_feeds/#{activity_feed.trackable_type.underscore}/#{activity_feed.action}",
      "activitie_feeds/#{activity_feed.trackable_type.underscore}",
      "activitie_feeds/activity_feed"
    ]
  end
end