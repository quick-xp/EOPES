module ApplicationHelper
  def active?(*controllers_name)
    return "active" if controllers_name.include?(params[:controller])
  end
end