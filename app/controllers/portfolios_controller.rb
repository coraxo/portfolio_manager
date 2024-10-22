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
    params.permit!
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user = Current.session.user

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully created' }
        format.json { render :show, status: :created, location: @portfolio }
      else
        format.html { render :new, status: :unprocessable_entity  }
        format.json { render json: { 'error': 'Could not create portfolio' }, status: :unprocessable_entity }
       end
    end
  end

  def show
  end

  def edit
    if Current.session.user.id != @portfolio.user.id
      respond_to do |format|
        format.html { redirect_to @portfolio, notice: 'Cannot edit other user\'s profile.' }
        format.json { render json: { 'error': 'Access denied' }, status: :forbidden }
      end
    end
  end

  def update
  end

  private

    def set_portfolio
      @portfolio = Portfolio.find(params.expect(:id))
    end

    def portfolio_params
      params.fetch(:portfolio, {})
    end
end
