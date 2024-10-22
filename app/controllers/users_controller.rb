class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new show create ]
  before_action :set_user, only: %i[ show edit update ]

  def new
    @user = User.new
  end

  def create
    params.permit!
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity  }
        format.json { render json: @recipe.user, status: :unprocessable_entity }
       end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

    def set_user
      @user = User.find(params.expect(:id))
    end

    def user_params
      params.fetch(:user, {})
    end
end