class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new show create ]
  before_action :set_user, only: %i[ show edit update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_portfolio_path, notice: 'User was successfully created. Please log in and create your portfolio now.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity  }
        format.json { render json: { 'error': 'Could not create user' }, status: :unprocessable_entity }
       end
    end
  end

  def show
  end

  def edit
    if Current.session.user.id != @user.id
      respond_to do |format|
        format.html { redirect_to user_path(@user), notice: 'Cannot edit other user.' }
        format.json { render json: { 'error': 'Access denied' }, status: :forbidden }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: "User settings successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user
      @user = User.find(params.expect(:id))
    end

    def user_params
      params.require(:user).permit(
        :email_address,
        :password
      )
    end
end
