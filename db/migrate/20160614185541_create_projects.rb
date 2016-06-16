class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string    :name
      t.integer   :total_points
      t.string    :items
    end
    add_attachment :projects, :opml
  end
end
