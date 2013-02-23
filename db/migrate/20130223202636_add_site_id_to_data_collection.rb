class AddSiteIdToDataCollection < ActiveRecord::Migration
  def change
    add_column :data_collections, :public, :int
  end
end
