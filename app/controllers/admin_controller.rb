class AdminController < ApplicationController


  def index
    current_user = session[:userid]
    exclude_ids = [current_user,30]
    @admins = Admin.where('id NOT IN (:ids)', ids: exclude_ids)
  end


  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    # Save the object
    if @admin.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Admin created successfully."
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    current_user = session[:userid]
    @admin = Admin.find_by(id: current_user)
  end

  def update
    @admin = Admin.find_by(id: params[:id])
    # Update the object
    if @admin.update_attributes(admin_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "Admin updated successfully."
      redirect_to(:controller => 'access', :action => 'admin_view')
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    Admin.find_by(params[:id]).destroy
    redirect_to(:action => 'index')
  end

private
  def admin_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned
      params.require(:admin).permit(:name,:email_id, :password, :password_confirmation,:created_at)
  end

end
