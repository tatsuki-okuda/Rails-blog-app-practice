# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # 複数のarticleを持つという意味になる
  # Userが削除されたら、紐づくデータも全て削除される
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy

  # いいねした記事だけを取取得することができる
  # 本来であればuserテーブルからいいねテーブルを解してarticleは取得できないがthoroughを使うことで可能になる
  # favoritesというモデルはganarateコマンドで作ってないので存在しないモデルだが、sorceを使うことで、そのモデルがどのモデルを対象とするのかを指定できる
  # 登録していない架空のモデルを登録することができる
  has_many :favorite_articles, through: :likes, source: :article

  # プロフィールは一人のユーザーに対して一つしかないので複数形にならない
  has_one :profile, dependent: :destroy

  # profileの情報を扱えるようにする
  # これを書くことで関数で定義しなくても値を使えるようになる
  # allow_nil: trueでぼっち演算子を定義して値がnillでも使えるようになる
  # delegate :birthday, :age, :gender, :introduction, to: :profile, allow_nil: true
  delegate :birthday, :age, :gender, to: :profile, allow_nil: true
  


  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def has_liked?(article)
    likes.exists?(article_id: article.id)
  end
  

  # ユーザーのIDもどきを表示させる
  def display_name
    # emaiを@で分割する
    # if profile && profile.nickname
    #   profile.nickname 
    # else
    #   self.email.split('@').first
    # # / => ['〜'],['〜']
    # end

    # ぼっち演算子
    profile&.nickname || self.email.split('@').first
  end

  # def birthday
  #   profile&.birthday
  # end

  # def gender
  #   profile&.gender
  # end
  
  
  
  def prepare_profile
    profile || build_profile
  end
  

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
  
  
end
