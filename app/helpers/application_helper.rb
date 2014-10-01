module ApplicationHelper
  def sort_links(attribute)
    p = params.dup
    p.delete :action
    p.delete :controller
    link_to("^", questions_path(p.merge(sort: {attribute => :asc }))) +
    link_to("v", questions_path(p.merge(sort: {attribute => :desc})))
  end
end
