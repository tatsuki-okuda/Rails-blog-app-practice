class NotificationFromAdminJob  < ApplicationJob
  queue_as :default

  # 非同期処理書くときはperformを絶対に書く。
  # このperformないが実行される
  def perform(msg)
    User.all.each do |user|
      NotificationFromAdminMailer.notify(user,msg).deliver_later
    end
  end
  
end