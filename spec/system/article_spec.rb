require 'rails_helper'

# tytpeごとにやることが変わるので、rails_helperにtypeを知らせないといけない。
RSpec.describe 'Article', type: :system do
  let!(:user) { (create(:user)) }
  let!(:articles) { create_list(:article, 3, user: user) }

  it "記事一覧が表示される" do
    # カピバラのメソッドでviasitがある。
    # そこにアクセスしてブラウザを開くもの
    visit root_path

    # pageはspecで用意されているメソッド
    # have contentはカピバラで用意されているメソッド
    # コンテンツにあるコンテンツがあるかどうかを判定してくれるメソッド
    # 今回はページのコンテンツにアーティクルのタイトつがあるかどうかの判定
    articles.each do | article |
      # have_contentだと偶然テストを十てしまう可能性がある。
      # expect(page).to have_content(article.title)

      # cssがぞ存在しているかどうか、クラスが存在しているかどうか、そのクラスのコンテンツが村zないしているかどうかを見ることができる。
      # card_titleのクラスを持つ要素のテキストが記事のタイトルと一致するかどうかを検証できる。
      expect(page).to have_css('.card_title', text: article.title)
    end
  end


  it "記事の詳細を表示できる" do
    visit root_path
    # click_onはカピバラのメソッドでテキストを指定するとそれをクリックしてくれるメソッド
    articles.each do | article |
      click_on article.title
      # 遷移したページでタイトルとコンテンツが一致しているかどうか。
      expect(page).to have_css('.article_title', text: article.title)
      expect(page).to have_css('.article_content', text: article.content.to_plain_text)
    end
  end
  
  
end
