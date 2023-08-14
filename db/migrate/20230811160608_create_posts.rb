class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.boolean :has_media
      t.string :upload_path
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
