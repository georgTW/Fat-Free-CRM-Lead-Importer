class Admin::ImportLeadsController < Admin::ApplicationController
  before_filter :require_user
  before_filter "set_current_tab('admin/import')"

  def index
    redirect_to :action => :new
  end

  def new
  end

  def create
    assigned = User.find(params[:import][:assigned_to])
    file = params[:import][:csv_file]
    gdrive = params[:import][:gdrive]

    if gdrive == '0'
      return_value = ImportLead.new(file).import_file(assigned)
    else
      return_value = ImportLead.new(file).import_gdrive(assigned)
    end
    error = return_value[0]
      if error == ''
        total = return_value[1]
        c = return_value[2]
        redirect_to new_admin_import_lead_path, :notice => "Total Leads for import  #{total}, #{c} duplicates skipped"
      else
        flash[:error] = t(:msg_gdrive_error, error)
        redirect_to new_admin_import_lead_path
    end
  end

end
