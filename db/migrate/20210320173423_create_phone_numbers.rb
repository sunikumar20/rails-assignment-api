class CreatePhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.belongs_to :account

      t.timestamps
    end
  end
end
