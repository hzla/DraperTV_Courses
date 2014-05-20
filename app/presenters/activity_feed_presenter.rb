class ActivityFeedPresenter < SimpleDelegator
  attr_reader :activity_feed

  def initialize(activity_feed, view)
    super(view)
    @activity_feed = activity_feed
  end

  def render_activity_feed
    render_partial
  end

  def render_partial
    locals = {activity_feed: activity_feed, presenter: self}
    locals[activity_feed.tobetrackable_type.underscore.to_sym] = activity_feed.tobetrackable
    render partial_path, locals
  end

  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for activity in #{partial_paths}")
  end

  def partial_paths
    [
      "activity_feeds/#{activity_feed.tobetrackable_type.underscore}/#{activity_feed.action}",
      "activity_feeds/#{activity_feed.tobetrackable_type.underscore}",
      "activity_feeds/activity_feed"
    ]
  end
end