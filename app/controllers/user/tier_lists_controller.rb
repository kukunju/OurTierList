class User::TierListsController < ApplicationController
  def new
    @theme = Theme.find(params[:theme_id])
    @tier_list = TierList.new
  end

  def edit
  end

  def show
  end

  def index
  end
end
