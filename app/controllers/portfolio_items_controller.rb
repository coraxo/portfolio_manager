class PortfolioItemsController < ApplicationController
  allow_unauthenticated_access only: %i[ show ]
  before_action :set_portfolio_item, only: %i[ show edit update destroy ]

  def index
    @portfolio_items = PortfolioItem.all

    respond_to do |format|
      format.html
      format.json { render json: @portfolio_items }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @portfolio_item }
    end
  end

  def new
    @user = Current.session.user
    @portfolio = @user.portfolio
    @portfolio_item = PortfolioItem.new
  end

  def edit
    @portfolio = @portfolio_item.portfolio
    if Current.session.user.id != @portfolio_item.portfolio.user.id
      respond_to do |format|
        format.html { redirect_to portfolio_item_path(@portfolio_item), notice: "Cannot edit other user's profile." }
        format.json { render json: { 'error': "Access denied" }, status: :forbidden }
      end
    end
  end

  def create
    @user = Current.session.user
    @portfolio = @user.portfolio
    @portfolio_item = PortfolioItem.new(portfolio_item_params)
    @portfolio_item.portfolio = @portfolio

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to @portfolio_item, notice: 'Portfolio item was successfully created.' }
        format.json { render json: @portfolio_item, status: :created, location: @portfolio_item }
      else
        format.html { render action: "new", status: :unprocessable_entity }
        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if Current.session.user.id != @portfolio_item.portfolio.user.id
      respond_to do |format|
        format.html { redirect_to portfolio_item_path(@portfolio_item), notice: "Cannot edit other user's profile." }
        format.json { render json: { 'error': "Access denied" }, status: :forbidden }
      end
    end

    respond_to do |format|
      if @portfolio_item.update(portfolio_item_params)
        format.html { redirect_to @portfolio_item, notice: 'Portfolio item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", status: :unprocessable_entity }
        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if Current.session.user.id != @portfolio_item.portfolio.user.id
      respond_to do |format|
        format.html { redirect_to portfolio_item_path(@portfolio_item), notice: "Cannot edit other user's profile." }
        format.json { render json: { 'error': "Access denied" }, status: :forbidden }
      end
    end

    @portfolio_item.destroy

    respond_to do |format|
      format.html { redirect_to portfolio_items_url }
      format.json { head :no_content }
    end
  end

  private

  def set_portfolio_item
    @portfolio_item = PortfolioItem.find(params.expect(:id))
  end

  def portfolio_item_params
    params.require(:portfolio_item).permit(:title, :description, :url, :repository_url)
  end
end