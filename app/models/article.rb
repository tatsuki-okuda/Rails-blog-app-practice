# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord

    has_one_attached :eyecatch
    has_rich_text :content

    validates :title, presence: true
    # length 2文字衣装１００文字以内
    validates :title, length: { minimum: 2, maximun: 100 }
    # 先頭に@があると登録できない
    validates :title, format: { with: /\A(?!@)/ }
    validates :content, presence: true
    
    # validates :content, length: { minimum: 10 }
    # # 同じ内容を登録できない
    # validates :content, uniqueness: true

    # # 独自ルール
    # validate :validate_title_and_contenrt_length

    # userに紐づくという意味
    belongs_to :user
    # 記事は複数のコメントを持っている
    # 生地から見たらコメントは複数あるものなので、複数形になる
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    
    
    

    private
    def validate_title_and_contenrt_length
        char_count = self.title.length + self.content.length
        errors.add(:content, '100文字以上で！') unless char_count > 100
    end

end
