class User::FavoritesController < ApplicationController

  def create
    @tier_list = TierList.find(params[:tier_list_id])
    unless @tier_list.favorited_by?(current_user)
      favorite = current_user.favorites.new(tier_list_id: @tier_list.id)
      favorite.save
    end
  end


  def destroy
    @tier_list = TierList.find(params[:tier_list_id])
    if @tier_list.favorited_by?(current_user)
      favorite = current_user.favorites.find_by(tier_list_id: @tier_list.id)
      favorite.destroy
    end
  end

end
