class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    # article_idが取れるのはパスを伝ってくるため（ルーティング参照）
    article = Article.find(params[:article_id])
    # article has many likes なので has manyでcreateできる
    article.likes.create!(user_id: current_user.id)
    redirect_to article_path(article)
  end

  def destroy
    article = Article.find(params[:article_id])
    like = article.likes.find_by!(user_id: current_user.id)
    like.destroy!
    redirect_to article_path(article), notice: '削除できました。'
  end
  
  
end