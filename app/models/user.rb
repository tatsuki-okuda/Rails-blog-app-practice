# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
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

  # フォロー機能
  # 自分がフォローしている時のデータを持ってくる
  # Railsでは何も指定がなければ外部キーをuser_idと見なすため、独自の外部キーが必要な時は指定する必要がある。
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy;
  # フォローされているデータをとってくる フォローしている人たちをfollowingで定義している
  has_many :followings, through: :following_relationships, source: :following

  # フォローしている人から見て、フォローしている人をとってくる
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy;
  has_many :followers, through: :follower_relationships, source: :follower

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

  # フォロー
  def follow!(user)

    # userがUserクラスのインスアタンスであるかをチェックする
    if user.is_a?(User)
      user_id = user.id
    else
      user_id = user
    end

    following_relationships.create!(following_id: user_id)
  end

  # アンフォロー
  def unfollow!()
    relation = following_relationships.find_by!(following_id: user.id)
    relation.destroy!
  end

  # フォローしているかどうかのチェック
  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
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
