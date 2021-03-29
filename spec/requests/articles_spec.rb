require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  # articles_pathにリクエストするのに必要なダミーデータ
  let!(:user) { create(:user)}
  let!(:articles) { create_list(:article, 3, user: user) }

  describe 'GET /articles' do
    it '200ステータスが帰ってくる' do
      # articleパスにリクエストを遅れる
      get articles_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /articles' do
    # ログ新していないとkizisakuseihできない
    context "ログインしている場合" do
      before do
        # deviceのメソッドとしてサインインしている状態のメソッドがあるが、diviceのメソッドはここでは使えないので
        # ヘルパーからメソッドをインストールする必要がある。
        sign_in user
      end
      # 記事をPOSTするときはリダイレクトされているので、記事が保存されているかどうかをみる。
      # リダイレクトだと、記事が保存されずにリダイレクトされているパターンもあるから。
      it '記事が保存されているのか' do
        # 記事を保存するときはパラメーターを送る必要がある。
        # パラメータ作成はrspecで用意されている。
        # { title: 'aaa', content: 'bbb'}　のようなハッシュを作成してくれる。
        article_params = attributes_for(:article)
        post articles_path({article: article_params})
        expect(response).to have_http_status(302)
        expect(Article.last.title).to eq(article_params[:title])
        expect(Article.last.content.body.to_plain_text).to eq(article_params[:content])
      end
    end


    # ログインしていない場合
    context "ログインしていない場合" do
      it "ログイン画面に遷移する" do
        article_params = attributes_for(:article)
        post articles_path({article: article_params})
        # ログインしていないときはリダイレクトされてログインページにとぶ
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
