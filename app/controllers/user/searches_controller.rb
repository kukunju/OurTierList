class User::SearchesController < ApplicationController
  def search

    @word = params[:word]

    if params[:new_order]
      @themes = Theme.new_order
    elsif params[:old_order]
      @themes = Theme.old_order
    elsif params[:order_many_tier_list]
      @themes = Theme.order_many_tier_list
    else
      @themes = Theme.all
    end

    if @word.present?

      @themes = @themes.where("name LIKE ?", "%#{@word}%")

      @averaged_tier_lists = {}

      @themes.each do |theme|
        tier_lists = theme.tier_lists
        averaged_tier_list = averaged_tier_list(tier_lists)
        @averaged_tier_lists[theme.id] = averaged_tier_list
      end

    else
      @themes = []
    end
  end
end