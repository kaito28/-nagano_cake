class Address < ApplicationRecord

   validates :name,  presence: true
   validates :postal_code,presence: true, format: {with: /\A\d{7}\z/}

   validates :address, presence: true
   belongs_to :customer

def address_property
   self.postal_code + self.address + self.name
end

end
