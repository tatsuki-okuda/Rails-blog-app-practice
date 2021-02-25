class AccountsController < ApplicationController
  def show
    @user = User.find(params[:id])
    # 自分がプロフィールを見た時はプロフィールの編集にリダイレクトする
    if @user == current_user
      redirect_to profile_path
    end
  end
end
