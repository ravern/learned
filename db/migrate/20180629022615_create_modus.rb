class CreateModus < ActiveRecord::Migration[5.2]
  def change
    create_table :modus do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
