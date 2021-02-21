class RemoveContentFormArticles < ActiveRecord::Migration[6.0]
  def change
    # リッチテキストの導入後はアーティクルに値を入れない
    # articleに紐づくcontentを移動される
    remove_column :articles, :content, :text
  end
end
