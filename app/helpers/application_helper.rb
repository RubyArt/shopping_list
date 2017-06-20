module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def main_menu_link(name, path, active, options = {})
    content_tag(:li, class: active ? 'active' : '') do
      link_to name, path, options
    end
  end
end
