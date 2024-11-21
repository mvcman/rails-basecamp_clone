class Tenant < ApplicationRecord
    has_many :employees
    has_many :tenant_employees
end
