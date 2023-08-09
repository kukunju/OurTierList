class User::ThemesController < ApplicationController
  def new
    @theme = Theme.new
    @theme.elements.build
    @theme.tags.build
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user_id = current_user.id

    if theme_params[:tags_attributes] != nil
      tag_names = theme_params[:tags_attributes].values.map { |tag| tag[:name] }.reject(&:blank?).uniq
    else
      tag_names = []
    end

    element_names = @theme.elements.map(&:name).uniq

    @theme.valid?

    if @theme.errors.any?
      render :new
    else
      @theme.tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
      @theme.elements = element_names.map { |name| Element.new(name: name) }
      if @theme.save
        redirect_to new_theme_tier_list_path(@theme.id), notice: 'テーマが正常に作成されました'
      else
        Rails.logger.info @theme.errors.full_messages
        render :new
      end
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
    params.require(:theme).permit(
      :name, elements_attributes: [:id, :name, :_destroy], tags_attributes: [:id, :name, :_destroy]
    )
  end
end
