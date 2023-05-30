class EntitiesController < ApplicationController
  before_action :authenticate_user!

  # GET /entities or /entities.json
  def index
    @group = current_user.groups.find(params[:group_id])
    @entities = @group.entities.order(created_at: :desc)
  end

  # GET /entities/1 or /entities/1.json
  def show; end

  # GET /entities/new
  def new
    @group= current_user.groups.find(params[:group_id])
    @entity = @group.entities.new
  end

  # GET /entities/1/edit
  def edit; end

  # POST /entities or /entities.json
  def create
    @group = current_user.groups.find(params[:group_id])
    @entity = current_user.entities.create(entity_params)
    if @entity.save
      @group_entity = @entity.group_entities.create(group_id: @group.id, entity_id: @entity.id)
      
      if @group_entity.save
        flash[:notice] = 'New transaction created sucessfully'
        redirect_to group_entities_path(@group)
      else
        flash.now[:alert] = 'Transaction category creation failed'
        render action: 'new'
      end
    else
      flash.now[:alert] = 'Transaction creation failed'
      render action: 'new'
  end
  end

  # PATCH/PUT /entities/1 or /entities/1.json
  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to entity_url(@entity), notice: 'Entity was successfully updated.' }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @entity = Entity.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to group_entities_url, notice: 'Entity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entity
    @entity = Entity.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def entity_params
    params.require(:entity).permit(:name, :amount)
  end
end
