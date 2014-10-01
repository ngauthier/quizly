module ApplicationHelper
  def sort_links(attribute)
    link_to("^", questions_path(merge_params(sort: {attribute => :asc }))) +
    link_to("v", questions_path(merge_params(sort: {attribute => :desc})))
  end

  def merge_params(opts = {})
    p = params.dup
    p.delete :action
    p.delete :controller
    p.delete :partial
    p.merge(opts)
  end
end
