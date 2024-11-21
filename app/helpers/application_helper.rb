module ApplicationHelper
    def current_tenant
        @current_tenant ||= Tenant.includes(:tenant_employees).where(tenant_employees: { user_id: current_user }).first
    end 

    def action_name(activity)
        t("public_activity.#{activity.key}")
    end 
end
