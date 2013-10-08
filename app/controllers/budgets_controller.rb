class BudgetsController < ApplicationController

  # use CanCan to authorize this resource
  authorize_resource

  decorates_assigned :budget
  decorates_assigned :budgets

  # GET /budgets
  # GET /budgets.json
  def index
    # TODO: implement filters
    @budgets = Budget.order("budgets.starts_at DESC, budgets.number ASC")
      .page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      #format.select2 { render json: { items: budgets.map(&:to_select2_json), total: @budgets.count} }
      #format.json { render json: @budgets }
    end
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
    @budget = Budget.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      # format.json { render json: @budget }
    end
  end

  # GET /budgets/new
  # GET /budgets/new.json
  def new
    @budget = Budget.new

    respond_to do |format|
      format.html # new.html.erb
      # format.json { render json: @budget }
    end
  end

  # GET /budgets/1/edit
  def edit
    @budget = Budget.find(params[:id])
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(params[:budget])

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, notice: 'Budget was successfully created.' }
        format.json { render json: @budget, status: :created, budget: @budget }
      else
        format.html { render action: "new" }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /budgets/1
  # PUT /budgets/1.json
  def update
    @budget = Budget.find(params[:id])

    respond_to do |format|
      if @budget.update_attributes(params[:budget])
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
        # format.json { head :no_content }
      else
        format.html { render action: "edit" }
        # format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  # def destroy
  #   @budget = Budget.find(params[:id])
  #   @budget.destroy

  #   respond_to do |format|
  #     format.html { redirect_to budgets_url }
  #     # format.json { head :no_content }
  #   end
  # end

end
