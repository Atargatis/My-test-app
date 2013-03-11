class UsersController < ApplicationController
  #before_filter :authenticate_user!
	#before_filter :authorize, :except => :index
  load_and_authorize_resource
	def index
		@users = User.order(:username).page(params[:page])#.per(15)
	end

	def show
		@user = User.find(params[:id])
	end
	
    def new
  	    @user = User.new
    end

  	def create
  		@user = User.new(params[:user])
  	if @user.save
      if current_user == @user
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        flash[:success] = "New user created!"
      end
  		  redirect_to @user # user_url
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      if current_user == @user
        sign_in @user
      end
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
end
