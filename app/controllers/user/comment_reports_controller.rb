class User::CommentReportsController < ApplicationController

  def completion
    @comment_id = params[:comment_id]
    @comment_report = CommentReport.new
    @report_reasons = ["迷惑行為やスパム", "不適切なコンテンツ", "著作権侵害","暴力的なコンテンツ","差別的な表現","プライバシーの侵害","性的なコンテンツ","嫌がらせ、いじめ","プロパガンダ","誤った情報","きのこの山"]
  end

  def create
    @comment_report = CommentReport.new(comment_report_params)
    @comment_report.user_id = current_user.id
    if @comment_report.save
      redirect_to tier_list_path(params[:tier_list_id]), notice: 'ご協力ありがとうございます。'
    else
      render :completion
    end
  end

  private

  def comment_report_params
    params.require(:comment_report).permit(:comment_id, :reason)
  end


end
