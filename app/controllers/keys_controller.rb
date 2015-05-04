class KeysController < ApplicationController
  before_filter :set_key, only: %i[show edit update destroy]

  def index
    @keys = current_user.keys
  end

  def show
  end

  def new
    @key = current_user.keys.new
  end

  def create
    @key = current_user.keys.build key_params

    if @key.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @key.update_attributes key_params
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    @key.destroy
    redirect_to keys_path
  end


  private

  def set_key
    @key = current_user.keys.find(params[:id])
  end

  def key_params
    params.require(:key).permit :name
  end
end
