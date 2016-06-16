class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :content
      t.integer  :points

      t.timestamps null: false
    end
  end
end
