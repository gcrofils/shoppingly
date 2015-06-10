class Home
  def cache_key
    "home/#{to_param}-#{updated_at.utc.to_s(:nsec)}"
  end

  def to_param
    @as_param ||= [
      posts.ids
    ].join('-')
  end

  def updated_at
    #@max_updated_at ||= [
    #  todays_video_picks.maximum(:updated_at),
    #  most_watched_videos.maximum(:updated_at),
    #  cat_videos.maximum(:updated_at)
    #].max
    @max_updated_at ||= [posts.maximum(:updated_at)].max
  end

  def posts
    #Video.todays_picks.limit(6)
    Post.all
  end
  
end