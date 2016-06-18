class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.full_name = params[:user][:full_name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Blocmarks #{@user.full_name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

private
  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
