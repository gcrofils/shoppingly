class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.references :pinnable, polymorphic: true, index: true
      t.text :keywords

      t.timestamps null: false
    end
  end
end
