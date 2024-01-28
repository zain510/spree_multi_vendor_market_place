module Spree
  module PermittedAttributes
    ATTRIBUTES << :vendor_attributes

    mattr_reader *ATTRIBUTES

    @@vendor_attributes = [:name, :about_us, :contact_us, :notification_email, :address, :company_identification_number, :vendor_legal_business_name, :account_number, :ifsc_code, :account_holder_name, :national_identification_number, :personal_identification_number, :company_identification_document, :bank_account_document, :national_identification_document, :personal_identification_document]
    @@vendor_attributes << :image
  end
end
