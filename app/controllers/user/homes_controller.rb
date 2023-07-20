class User::HomesController < ApplicationController
  def top
    @themes = Theme.order_many_tier_list.limit(10)
  end

  def about
  end
end
