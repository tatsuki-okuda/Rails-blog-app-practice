# frozen_string_literal: true

module UserDecorator

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

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
  
end
