class User::CommentsController < ApplicationController

  def create
    @tier_list = TierList.find(params[:tier_list_id])
    comment = current_user.comments.build(comment_params)
    comment.tier_list_id = @tier_list.id


    if comment.save
      flash.now[:success] = "コメントが保存されました。"
    else
      flash.now[:error] = "コメントの保存に失敗しました。"
    end

    @comments = @tier_list.comments.active
  end

  def update
    @comment = Comment.find(params[:id])
    @tier_list = TierList.find(params[:tier_list_id])

    if  @comment.user == current_user
      @comment.update(is_deleted: true)
      flash[:success] = "コメントを削除しました。"
    else
      flash[:error] = "コメントの削除に失敗しました。"
    end


    @comments = @tier_list.comments.active
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :tier_list_id)
  end

end
