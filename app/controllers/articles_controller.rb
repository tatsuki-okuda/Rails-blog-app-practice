class ArticlesController < ApplicationController
    # railsで一覧表示するときはindexを使うのがルールになっている
    def index
        # render 'home/index'
        # @article = Article.first

        # データベースから全ての値を取得する
        @articles = Article.all
    end
    
end