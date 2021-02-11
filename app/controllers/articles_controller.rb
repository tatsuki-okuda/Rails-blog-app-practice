class ArticlesController < ApplicationController

    # 各アクションの前に発火するアクションを追加できる
    # before_action :set_article, only: [:show, :edit, :update,]
    before_action :set_article, only: [:show]
    before_action :set_current_article, only:[:edit, :update]
    # diviseが用意しているメソッド
    # ログインしてい状態だと昨日が使えなくなる
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    # railsで一覧表示するときはindexを使うのがルールになっている
    def index

        # 意図的にエラーを起こす
        # raise StandardError

        # render 'home/index'
        # @article = Article.first

        # データベースから全ての値を取得する
        @articles = Article.all
    end

    def show
        # 投稿のIDを元にデータベースからデータを抜き出す
        # @article = Article.find(params[:id])
    end

    def  new
        # フォームに渡す中身のない側だけのインスアンス変数を作る
        # @article = Article.new()
        # ログインしているユーザーの情報を取得する
        @article = current_user.articles.build
    end

    def create
        # @article = Article.new(article_params)
        @article = current_user.articles.build(article_params)
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
        # @article = Article.find(params[:id])

        # ログインしているユーザーの記事から探し出す
        #current_userではなくArticlesだと全体の生地からの検索になるので、他のユーザーの記事も含んでしまう
        # @article = current_user.articles.find(params[:id])
    end

    def update
        # @article = Article.find(params[:id])
        # @article = current_user.articles.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path(@article), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def destroy
        # railsにおいてインスタンス変数は特別な意味を持ち。viewに表示する役割がある。
        # destroyにおいてはviewに表示させる必要がないので、インスタンス変数にはせずにアクションないの変数に留めておく。
        # article = Article.find(params[:id])

        # Articleだと全部の生地から削除できるので、ログインユーザーに限らせる
        article = current_user.articles.find(params[:id])

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

    def set_article
        # インスタンス変数でて儀することで、他のアクションからでも値をs取得できる。
        # ただの変数の定義だと値を再利用できなくなる
        @article = Article.find(params[:id])
    end

    def set_current_article
        @article = current_user.articles.find(params[:id])
    end
    

end
