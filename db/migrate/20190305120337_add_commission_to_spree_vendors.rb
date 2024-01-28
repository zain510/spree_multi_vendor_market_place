class AddCommissionToSpreeVendors < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_vendors, :commission_rate, :float, default: '0.0'
  end
end
