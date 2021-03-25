# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint           not null
#  following_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_follower_id   (follower_id)
#  index_relationships_on_following_id  (following_id)
#
class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  # コールバック
  # データーベースの更新時にアクションすることで、メールを確実に飛ばす。
  after_create :send_email

  private
  def send_email
    RelationshipMailer.new_follower(following, follower).deliver_now
  end
  
end