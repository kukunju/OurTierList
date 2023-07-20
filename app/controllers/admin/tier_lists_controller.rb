class Admin::TierListsController < ApplicationController
  skip_before_action :authenticate_user!
  def show
  end

  def index
  end
end
