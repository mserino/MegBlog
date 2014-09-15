class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.text :title
      t.text :description

      t.timestamps
    end
  end
end
