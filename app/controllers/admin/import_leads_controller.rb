require 'open3'
class Admin::ImportLeadsController < Admin::ApplicationController
  before_action :require_admin_user
  before_action "set_current_tab('admin/import_leads')"

  def index
    redirect_to :action => :new
  end

  def new
    path = File.expand_path("../../../helpers/gdrive_import", __FILE__)
    stdout, stderr, status = Open3.capture3(path, 'list')
    result = []
    stdout.split("\n").map do |pair|
      id, name, date = pair.split(';')
      label = name + ' (' + date + ')'
      a = [id, label]
      result.push(a)
    end
    @gdrive_files = result if result.present?
  end

  def create
    assigned = User.find(params[:import][:assigned_to])
    campaign = Campaign.find(params[:import][:campaign_id]) if params[:import][:campaign_id].present?
    file = params[:import][:csv_file]
    gdrive_id = params[:import][:gdrive_file_id]

    if gdrive_id.blank?
      return_value = ImportLead.new(file).import_file(assigned, campaign)
    else
      return_value = ImportLead.new(file).import_gdrive(gdrive_id, assigned, campaign)
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
