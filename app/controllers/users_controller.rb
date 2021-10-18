class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :load_user, only: [:show, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

	def show; end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = t('titles.welcome')
			redirect_to @user
		else
			render :new
		end
	end

	def edit; end

	def update
		if @user.update(user_params)
			flash[:success] = t('messages.profile_update')
			redirect_to @user
		else
			render :edit
		end
	end
	
	def destroy
		User.find_by(id: params[:id]).destroy
		flash[:success] = t('messages.user_delete')
		redirect_to users_url
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	# Confirms a logged-in user.
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = t('messages.pls_login')
			redirect_to login_url
		end
	end

	# Confirms the correct user.
	def correct_user
		@user = User.find_by(id: params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end

	# Confirms an admin user.
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

	# Check is existed user
	def load_user
		@user = User.find_by(id: params[:id])
		return if @user.present?
		flash[:danger] = t('messages.user_not_exist')
		redirect_to(root_url)
	end
end
