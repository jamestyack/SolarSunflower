class RemoveSiteIdFromDataCollection < ActiveRecord::Migration
  def up
      remove_column :data_collections, :site_id
  end

  def down
  end
end
