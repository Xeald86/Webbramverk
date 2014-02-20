class ResourceTypesController < ApplicationController
  
  before_action :default_format_json
  before_filter :restrict_access
  before_filter :user_authentication_required, :except => [:index, :show]
  
  respond_to :xml, :json
  
  def index
    #/resource_types/
    @types = ResourceType.all
    respond_with(@types.limit(limit_param).offset(offset_param))
  end
  
  def create
    rt = ResourceType.new
    rt.typeName = params[:typeName]
    
    if rt.valid?
      if rt.save
        created_success(201, 201, "A new resource-type has been created", resource_types_path + "/" + rt.id.to_s()) 
      else
        server_error
      end
    else
      validation_error(rt)
    end
  end
  
  def update
    rt = ResourceType.find_by(id: params[:id])
      if params.has_key?(:typeName)
        rt.typeName = params[:typeName]
      end
    
      if rt.save
        created_success(201, 201, "Resource-type has been updated", resource_types_path + "/" + rt.id.to_s()) 
      else
        server_error
      end
  end
  
  def destroy
    if ResourceType.find_by(id: params[:id])
      rt = ResourceType.find_by(id: params[:id])
      rt.destroy
      created_success(200, 200, "Resource-type deleted", "")
    else
      no_content
    end
  end
  
  def show
    if params[:resource_id]
      #/resources/:resource_id/resource_type/
      @type = Resource.find_by_id(params[:resource_id]).resource_type
    else
      #/resource_types/:id/
      @type = ResourceType.find_by_id(params[:id])
    end
    if @type != nil
      respond_with(@type)
    else
      no_content
    end
  end
end