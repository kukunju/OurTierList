class User::ThemesController < ApplicationController
  def new
    @theme = Theme.new
    @theme.elements.build
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user_id = current_user.id
    tag_list = params[:theme][:tag_names].split(',')
    element_list = params[:theme][:element_names].split(',')

    if @theme.save
      @theme.save_tag(tag_list)
      @theme.save_elements(element_list)
      redirect_to new_theme_tier_list_path(@theme.id), notice: 'テーマが正常に作成されました'
    else
      render :new
    end
  end

  def index
    if params[:new_order]
      @themes = Theme.new_order
    elsif params[:old_order]
      @themes = Theme.old_order
    elsif params[:order_many_tier_list]
      @themes = Theme.order_many_tier_list
    else
      @themes = Theme.all
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
