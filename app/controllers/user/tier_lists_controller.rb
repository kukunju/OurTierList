class User::TierListsController < ApplicationController
  def new
    @theme = Theme.find(params[:theme_id])
    @tier_list = @theme.tier_lists.build
    @tier_list.selected_elements.build
  end


  def create
    params[:selected_elements] = JSON.parse(params[:selected_elements])
    @theme = Theme.find(params[:theme_id])
    @tier_list = @theme.tier_lists.build(tier_list_params)
    @tier_list.user = current_user


    if @tier_list.save
      params[:selected_elements].each do |se|
        @tier_list.selected_elements.create(
          element_id: se[:element_id],
          tier: se[:tier]
        )
      end
      redirect_to @tier_list, notice: 'Tier list was successfully created.'
    else
      render :new
    end
  end



  def edit
    @tier_list = TierList.find(params[:id])
  end
  
  def update
    params[:selected_elements] = JSON.parse(params[:selected_elements])
    @tier_list = TierList.find(params[:id])

    if @tier_list.update(tier_list_params)
      @tier_list.selected_elements.destroy_all
      params[:selected_elements].each do |se|
        @tier_list.selected_elements.create(
          element_id: se[:element_id],
          tier: se[:tier]
        )
      end
      redirect_to @tier_list, notice: 'Tier list was successfully updated.'
    else
      render :edit
    end
  end


  def show
    @tier_list = TierList.find(params[:id])
  end

  def index
  end

  private

def tier_list_params
  params.require(:tier_list).permit(:comment)
end
end
