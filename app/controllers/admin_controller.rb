class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, ['super_admin', 'site_admin', 'content_manager'])
  end
  authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end


end
