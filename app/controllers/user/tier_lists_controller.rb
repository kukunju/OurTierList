class User::TierListsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

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


    if params[:selected_elements].any? { |element| element['tier'].nil? }
      @tier_list.errors.add(:base, "すべての要素をTierListに追加してください")
      render :new
    else
      if @tier_list.save
        params[:selected_elements].each do |se|
          @tier_list.selected_elements.create(
            element_id: se[:element_id],
            tier: se[:tier]
          )
        end
        redirect_to @tier_list, notice: 'TierListを保存しました.'
      else
        render :new
      end
    end
  end



  def edit
    @tier_list = TierList.find(params[:id])
  end

  def update
    @tier_list = TierList.find(params[:id])

    if params[:update_mode] == 'tier_list_edit'
      params[:selected_elements] = JSON.parse(params[:selected_elements])

      if @tier_list.update(tier_list_params)
        @tier_list.selected_elements.destroy_all
        params[:selected_elements].each do |se|
          @tier_list.selected_elements.create(
            element_id: se[:element_id],
            tier: se[:tier]
          )
        end
        redirect_to @tier_list, notice: 'TierListを保存しました.'
      else
        render :edit
      end
    elsif params[:update_mode] == 'tier_list_invalidation'
      @tier_list.update(is_deleted: true)
      flash[:success] = "TierListを削除しました。"
      redirect_to user_path(current_user.id)
    else
      redirect_to user_path(current_user.id)
    end
  end


  def show
    @tier_list = TierList.find(params[:id])
    @comments = @tier_list.comments.where(is_deleted: false)

    if @tier_list.is_deleted || @tier_list.theme.is_deleted
      redirect_to tier_lists_path
    end
  end

  def index
    @theme_filtaring = params[:theme_filtering]

    if params[:new_order]
      @tier_lists = TierList.new_order.active.page(params[:page])
    elsif params[:old_order]
      @tier_lists = TierList.old_order.active.page(params[:page])
    elsif params[:order_many_favorites]
      @tier_lists = TierList.order_many_favorites.active.page(params[:page])
    else
      @tier_lists = TierList.all.active.page(params[:page])
    end

    if @theme_filtaring.present?
      @tier_lists = @tier_lists.where(theme_id: @theme_filtaring).active.page(params[:page])
    end
  end

  private

  def tier_list_params
    params.require(:tier_list).permit(:comment)
  end
end
