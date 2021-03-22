module ArticleDecorator

  def display_created_at
    #  18n は国際化
    #  ja.ymlのデフォルト設定が反映される
     I18n.l(self.created_at, format: :default)
  end

  def author_name
      user.display_name
  end

  def like_count
      likes.count
  end
  
end