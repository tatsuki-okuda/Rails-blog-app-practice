class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|

      # userに紐付ける
      # null: falseでカラムに絶対に値が入っていないといけない制約を加える
      # userにアーティクルを絶対的に紐づける
      t.references :user, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
