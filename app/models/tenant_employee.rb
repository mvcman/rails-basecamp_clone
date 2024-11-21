class TenantEmployee < ApplicationRecord
  belongs_to :tenant
  belongs_to :user
end
