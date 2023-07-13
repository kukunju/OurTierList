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

private

def theme_params
  params.require(:theme).permit(:name)
end

end

