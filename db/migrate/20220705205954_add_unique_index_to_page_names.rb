class AddUniqueIndexToPageNames < ActiveRecord::Migration[7.0]
  def change
    add_index :pages, :name, unique: true
  end
end
