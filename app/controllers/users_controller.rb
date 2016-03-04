class UsersController < ApplicationController
  
  before_action :set_user, :authenticate!, only: [:edit, :update] 
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Thank you for joining Microposts!"
      redirect_to @user
    else
      render 'new'
   end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_profile)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user , notice: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit', flash: { danger: "error" }
    end
  end
  
  def edit
  end
  
  def follower
     @user = User.find(params[:id])
     @follower = @user.follower_users
  end
  
  def following
     @user = User.find(params[:id])
     @following = @user.following_users
  end
  
  
  private

  # get parameters for sign up
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # get parameters for profile editing
  def user_profile
    params.require(:user).permit(:name, :email, :profile, :city, :password, :password_confirmation)
  end

  # get a user instance with :id parameter
  def set_user
    @user = User.find(params[:id])
  end

  # check current_user is editing self ?
  def authenticate!
    if @user != current_user
      redirect_to root_url, flash: { danger: "不正なアクセス" }
    end
  end
  
end