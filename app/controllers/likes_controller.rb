class LikesController < ApplicationController
  before_action :authenticate_user!


  def show
    article = Article.find(params[:article_id])
    like_status = current_user.has_liked?(article)
    # APIを使う場合はrenderでjsonデーターを渡す
    render json: { hasLiked: like_status }
  end
  

  def create
    # article_idが取れるのはパスを伝ってくるため（ルーティング参照）
    article = Article.find(params[:article_id])
    # article has many likes なので has manyでcreateできる
    article.likes.create!(user_id: current_user.id)

    # apiを使う場合はjsで判定するのでredirectヘルパーメソッドを使う必要はない
    # redirect_to article_path(article)

    render json: { status: 'ok' }
  end

  def destroy
    article = Article.find(params[:article_id])
    like = article.likes.find_by!(user_id: current_user.id)
    like.destroy!
    # redirect_to article_path(article), notice: '削除できました。'

    render json: { status: 'ok' }
  end
  
  
end