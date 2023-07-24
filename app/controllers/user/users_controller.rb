class User::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tier_lists = TierList.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました！"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def favorite
    @user = User.find(params[:user_id])
    @tier_lists = @user.favorites.includes(:tier_list).map(&:tier_list)
  end

  def leave
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

end
