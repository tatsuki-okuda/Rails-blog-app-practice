class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true


    def display_created_at
        #  18n は国際化 
        #  ja.ymlのデフォルト設定が反映される  
         I18n.l(self.created_at, format: :default) 
    end
    
end
