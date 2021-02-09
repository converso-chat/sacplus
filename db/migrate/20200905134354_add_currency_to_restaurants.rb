class AddCurrencyToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :currency, :string, default: 'BRL'
  end
end
