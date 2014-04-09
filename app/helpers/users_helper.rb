module UsersHelper
  def users_sort_value
    if @users_search && @users_search.sorts.present?
      [@users_search.sorts.first.name, @users_search.sorts.first.dir].join(' ')
    end
  end
end
