class TemplatesController < ApplicationController 
    def index
        @templates = current_user.templates.ordered
    end
end 
