# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
    validates :title, presence: true
    # length 2文字衣装１００文字以内
    validates :title, length: { minimum: 2, maximun: 100 }
    # 先頭に@があると登録できない
    validates :title, format: { with: /\A(?!@)/ }
    validates :content, presence: true
    validates :content, length: { minimum: 10 }
    # 同じ内容を登録できない
    validates :content, uniqueness: true

    # 独自ルール
    validate :validate_title_and_contenrt_length

    def display_created_at
        #  18n は国際化
        #  ja.ymlのデフォルト設定が反映される
         I18n.l(self.created_at, format: :default)
    end

    private
    def validate_title_and_contenrt_length
        char_count = self.title.length + self.content.length
        errors.add(:content, '100文字以上で！') unless char_count > 100
    end

end
