class User::ThemeReportsController < ApplicationController

  def completion
    @theme_id = params[:theme_id]
    @theme_report = ThemeReport.new
    @report_reasons = ["迷惑行為やスパム", "不適切なコンテンツ", "著作権侵害","暴力的なコンテンツ","差別的な表現","プライバシーの侵害","性的なコンテンツ","嫌がらせ、いじめ","プロパガンダ","誤った情報","きのこの山"]
  end

  def create
    @theme_report = ThemeReport.new(theme_report_params)
    @theme_report.user_id = current_user.id
    if @theme_report.save
      redirect_to themes_path, notice: 'ご協力ありがとうございます。'
    else
      render :completion
    end
  end

  private

  def theme_report_params
    params.require(:theme_report).permit(:theme_id, :reason)
  end


end