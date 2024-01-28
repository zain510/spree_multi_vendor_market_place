class AddColumnsToVendors < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_vendors, :address, :string
    add_column :spree_vendors, :company_identification_number, :string
    add_column :spree_vendors, :vendor_legal_business_name, :string
    add_column :spree_vendors, :account_number, :string
    add_column :spree_vendors, :ifsc_code, :string
    add_column :spree_vendors, :account_holder_name, :string
    add_column :spree_vendors, :national_identification_number, :string
    add_column :spree_vendors, :personal_identification_number, :string
  end
end
