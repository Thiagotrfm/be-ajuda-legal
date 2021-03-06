class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :cpf
      t.string :phone

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :cpf, unique: true
  end
end
