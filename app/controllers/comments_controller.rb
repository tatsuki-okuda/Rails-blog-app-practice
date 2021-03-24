class CommentsController < ApplicationController

  def index
    article = Article.find(params[:article_id])
    comments = article.comments
    render json: comments
  end
  

  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end

  def create
      article = Article.find(params[:article_id])
      @comment = article.comments.build(comment_params)
      # if @comment.save
      #   redirect_to article_path(article), notice: 'コメントを追加'
      # else
      #   flash.now[:error] = '更新できませんでした'
      #   render :new
      # end

      # APIでや流ときはvaridateをJS側でやるので、rubyでは絶対に保存できる状態
      @comment.save!
      render json: @comment
  end
  
  private
  def comment_params
      params.require(:comment).permit(:content)
  end
  
end