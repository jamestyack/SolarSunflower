class CreateCollectionPoints < ActiveRecord::Migration
  def change
    create_table :collection_points do |t|
      t.string :name
      t.references :site

      t.timestamps
    end
    add_index :collection_points, :site_id
  end
end
