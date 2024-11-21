class HomeController < ApplicationController 
    def index
        tenant_employee = TenantEmployee.find_by(user_id: current_user)
        if !tenant_employee
            redirect_to new_tenant_path
        else
            @tenant = tenant_employee.tenant
        end
    end
end