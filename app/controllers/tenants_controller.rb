class TenantsController < ApplicationController 
    def new 
        @tenant = Tenant.new
    end 

    def edit 
    end

    def create 
        @tenant = Tenant.new(tenant_params)
        @tenant.created_by = current_user.id
        if @tenant.save
            @tenant.tenant_employees.create(user_id: current_user.id, role: "admin")
            redirect_to root_path
        else 
            render :new
        end
    end

    def update 
        @tenant.update(tenant_params)
        redirect_to root_path
    end 

    private    
    
    def set_tenant 
        @tenant = Tenant.find(params[:id])
    end

    def tenant_params 
        params.require(:tenant).permit(:name)
    end
end