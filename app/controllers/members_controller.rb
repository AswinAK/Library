class MembersController < ApplicationController
  # GET /members
  def index
    @members = Member.all
  end


  # GET /members/new
  def new
    @member = Member.new
  end

  def edit
    current_user = session[:userid]
    puts "Hello Sahib " + " " + current_user.to_s
    @member = Member.find_by(id: current_user)
  end

  # POST /members
  def create
    @member = Member.new(member_params)
    # Save the object
    if @member.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Admin created successfully."
      redirect_to(:controller => 'access', :action => 'login')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end
  # PATCH/PUT /members/1
  def update
    @member = Member.find_by(id: params[:id])
    if @member.update(member_params)
      flash[:notice] = "Member updated successfully."
      redirect_to(:controller => 'access', :action => 'member_view')
    else
      render action: 'edit'
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

    # Only allow a trusted parameter "white list" through.
  private
    def member_params
      params.require(:member).permit(:name,:email_id, :password, :password_confirmation,:created_at)
    end
  end

