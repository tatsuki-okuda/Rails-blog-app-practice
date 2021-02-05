class ArticlesController < ApplicationController
    # railsで一覧表示するときはindexを使うのがルールになっている
    def index
        # render 'home/index'
        # @article = Article.first

        # データベースから全ての値を取得する
        @articles = Article.all
    end

    def show
        # 投稿のIDを元にデータベースからデータを抜き出す
        @article = Article.find(params[:id])
    end

    def  new
        # フォームに渡す中身のない側だけのインスアンス変数を作る
        @article = Article.new()
    end
    
    def create
        @article = Article.new(article_params)
        # データを保存する
        # データが保存できた時とできなかった時とで処理を分ける
        # 保存に成功したらarticleのページに飛ばす
        if @article.save
            # 第二引数でフラッシュ（アラート）を設定できる
            redirect_to article_path(@article), notice: '保存できました'
        else
            flash.now[:error] = '保存に失敗しました'
            render :new
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path(@article), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def destroy
        article = Article.find(params[:id])
        #  !をつけるときに削除されなかった時に例外処理をくらえられる。
        # 削除の場合は削除前と後で整合性を取らないといけない。
        article.destroy!
        redirect_to root_path, notice: '削除できました。'
    end
    
    
    
    

    private
    def article_params
        # strong paramater
        # フォームから送信された情報は信用できないので、その中からtiitleとcontentは保存できるようにする
        # これにより、意図的に書き換えられたフォームの値を保存しない
        puts '----------'
        puts params
        puts '----------'
        params.require(:article).permit(:title, :content)
    end
    
    
end