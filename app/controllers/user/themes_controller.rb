class User::ThemesController < ApplicationController
  def new
    @theme = Theme.new
    @theme.elements.build
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user_id = current_user.id
    tag_list = params[:theme][:tag_names].split('、')
    element_list = params[:theme][:element_names].split('、')

    @theme.valid?
    @theme.errors.add(:tag_names, 'を入力してください') if tag_list.empty?
    @theme.errors.add(:element_names, 'を入力してください') if element_list.empty?


    if @theme.errors.any?
      render :new
    else
      @theme.save
      @theme.save_tag(tag_list)
      @theme.save_elements(element_list)
      redirect_to new_theme_tier_list_path(@theme.id), notice: 'テーマが正常に作成されました'
    end
  end

  def index
    if params[:new_order]
      @themes = Theme.new_order.active.page(params[:page])
    elsif params[:old_order]
      @themes = Theme.old_order.active.page(params[:page])
    elsif params[:order_many_tier_list]
      @themes = Theme.order_many_tier_list.active.page(params[:page])
    else
      @themes = Theme.all.active.page(params[:page])
    end

    @averaged_tier_lists = {}

    @themes.each do |theme|
      tier_lists = theme.tier_lists
      averaged_tier_list = averaged_tier_list(tier_lists)
      @averaged_tier_lists[theme.id] = averaged_tier_list
    end
  end

  private



  def theme_params
    params.require(:theme).permit(:name)
  end
end
