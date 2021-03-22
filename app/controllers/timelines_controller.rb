class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    # pluck は指定したデータのみを取得できる
    user_ids = current_user.followings.pluck(:id)
    # 取得したユーザーIDと一致するアーティクルをとってくる。
    @articles = Article.where(user_id: user_ids)
  end
  
end