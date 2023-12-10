class TripsController < ApplicationController
    before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.all
  end

  def show
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trips_path, notice: 'Voyage créé avec succès.'
    else
      render :new
    end
  end  

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to @trip, notice: 'Voyage mis à jour avec succès.', format: :html
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_url, notice: 'Voyage supprimé avec succès.'
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:user_id, :destination, :description, :date_debut, :date_fin)
  end
end
