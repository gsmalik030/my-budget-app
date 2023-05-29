class CreateGroupEntities < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:group_entities)
    create_table :group_entities do |t|
      t.references :group, null: false, foreign_key: true
      t.references :operation, null: false, foreign_key: true
      t.timestamps
    end
  end
end
end