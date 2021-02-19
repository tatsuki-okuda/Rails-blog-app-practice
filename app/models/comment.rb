# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#
class Comment < ApplicationRecord

    # コメントは一つの記事に紐づく
    # コメントから見た時に対象となる記事は一つなので、単数系
    belongs_to :article
    validates :content, presence: true
end
