class AddWinToPossiblity < ActiveRecord::Migration
  def change
    add_column :possibilities, :won, :integer
    add_column :possibilities, :lost, :integer
  end
end
