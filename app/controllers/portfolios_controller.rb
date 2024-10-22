class PortfoliosController < ApplicationController
  allow_unauthenticated_access only: %i[ show ]
  before_action :set_portfolio, only: %i[ show edit update ]

  def index
    @portfolios = Portfolio.all
  end

  def new
    @user = Current.session.user
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    user = Current.session.user

    if user.portfolio
      respond_to do |format|
        format.html { redirect_to portfolio_path(user.portfolio), notice: 'Portfolio creation failed, portfolio already exists' }
        format.json { render json: { 'error': 'Portfolio already exists' }, status: :unprocessable_entity }
      end
    else
      @portfolio.user = user
      respond_to do |format|
        if @portfolio.save
          format.html { redirect_to portfolio_path(@portfolio), notice: 'Portfolio was successfully created' }
          format.json { render :show, status: :created, location: @portfolio }
        else
          format.html { render :new, status: :unprocessable_entity  }
          format.json { render json: { 'error': 'Could not create portfolio' }, status: :unprocessable_entity }
        end
      end
    end
  end

  def show
  end

  def edit
    if Current.session.user.id != @portfolio.user.id
      respond_to do |format|
        format.html { redirect_to portfolio_path(@portfolio), notice: 'Cannot edit other user\'s profile.' }
        format.json { render json: { 'error': 'Access denied' }, status: :forbidden }
      end
    end
  end

  def update
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to portfolio_path(@portfolio), notice: "Portfolio settings successfully updated." }
        format.json { render :show, status: :ok, location: @portfolio }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_portfolio
      @portfolio = Portfolio.find(params.expect(:id))
    end

    def portfolio_params
      params.require(:portfolio).permit(
        :title,
        :introduction,
        :description
      )
    end
end
