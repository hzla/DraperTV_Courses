module PostsHelper
  def posts_sort_value
    if @posts_search && @posts_search.sorts.present?
      [@posts_search.sorts.first.name, @posts_search.sorts.first.dir].join(' ')
    end
  end
end
