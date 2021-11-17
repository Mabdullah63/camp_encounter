module SortingHelper
  def get_sort_type(field)
    if field == params[:sorting_column]
      if params[:sort_type] == "asc"
        return "desc"
      elsif params[:sort_type] == "desc"
        return "asc"
      end
    else
      return "asc"
    end
  end
end