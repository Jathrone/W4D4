class DropUniquenessOnAlbumBandId < ActiveRecord::Migration[5.2]
  def change
    remove_index :albums, :band_id
    add_index :albums, :band_id
  end
end
