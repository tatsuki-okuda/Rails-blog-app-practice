require 'rails_helper'

RSpec.describe Article, type: :model do

  # let!(:user) do
  #   user = User.create!({
  #     email: 'test@example.com',
  #     password: 'password'
  #   })
  # end


  # actory_botの場合
  let!(:user) { create(:user) }
  # 値を書き換えることもできる
  # let!(:user) { create(:user), email: 'test@test.com' }


  # 確認したいことを itで作る
  context 'タイトルと内容が入力されている' do
    # before do
    #   user = User.create!({
    #     email: 'test@example.com',
    #     password: 'password'
    #   })
    #   @article = user.articles.build({
    #     title: Faker::Lorem.characters(number: 10),
    #     content: Faker::Lorem.characters(number: 300)
    #   })
    # end

    # letを使う場合はbeforeを使えなくなる
    # let!(:article) do
    #   article = user.articles.build({
    #     title: Faker::Lorem.characters(number: 10),
    #     content: Faker::Lorem.characters(number: 300)
    #   })
    # end

    # user:はuserに紐づく
    let!(:article) { build(:article, user: user) }

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  context "タイトルが１文字の場合" do
    # let!(:article) do
    #   article = user.articles.create({
    #     title: Faker::Lorem.characters(number: 1),
    #     content: Faker::Lorem.characters(number: 300)
    #   })
    # end

    # ここでのcreateは　create!　になるので保存できない場合は例外が発生して姉妹、ここでテストが終わってしまう。
    # なので、別の方法で保存させる
    let!(:article) { build(:article, title: Faker::Lorem.characters(number: 1), user: user) }

    before do
      article.save
    end

    it "保存できない" do
      # titleに関するエラーメッセージをとってくる
      # errosは配列でくるのでその０番目を取得
      # その０番目のメッセージが　eq()と同じである時
      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください')
    end
    
  end
  
end
