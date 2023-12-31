class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top,:about]
  before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end

  protected

  def only_current_user(user)
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def averaged_tier_list(tier_lists)
    tier_list_count = tier_lists.count

    averaged_tier_list = TierList.new

    selected_elements = tier_lists.flat_map(&:selected_elements)
    grouped_elements = selected_elements.group_by(&:element_id)

    grouped_elements.each do |element_id, elements|
      total_tier = elements.sum(&:tier)
      average_tier = (total_tier.to_f / tier_list_count).round

      averaged_tier_list.selected_elements.build(element_id: element_id, tier: average_tier)
    end

  averaged_tier_list
  end
end
