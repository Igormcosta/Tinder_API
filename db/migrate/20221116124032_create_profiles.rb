class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.date :birth_date
      t.string :genre

      t.timestamps
    end
  end
end
