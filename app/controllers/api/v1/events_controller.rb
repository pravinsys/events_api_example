class Api::V1::EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :register]

  def index
    @events = Event.all
    render json: @events, each_serializer: EventSerializer
  end

  def show
    if @event.present?
      render json: @event, serializer: EventSerializer, status: :ok
    else
      head :not_found
    end
  end
  
  def create
    event = Event.new(create_params)

    if event.save
      render json: event, serializer: EventSerializer, status: :created
    else
      render json: error_json(event), status: :unprocessable_entity
    end
  end

  def update
    if @event.update(create_params)
      render json: @event, serializer: EventSerializer, status: :created
    else
      render json: error_json(@event), status: :unprocessable_entity
    end
  end

  def register
    user = User.current_user
    if user
      @event.users << user unless(@event.users.exists?(user.id))
      render json: @event.reload, serializer: EventSerializer, status: :created
    else
      head :unauthorized
      return false
    end
  end

  def picture
    event = Event.find_by(id: params[:id])

    if event&.picture&.attached?
      redirect_to rails_blob_url(event.picture)
    else
      head :not_found
    end
  end


  private

  def create_params
    params.require(:event).permit(:name, :description, :start_date, :end_date, :picture)
  end

  def error_json(event)
    { errors: event.errors.full_messages }
  end

  def set_event
    @event = Event.find_by(id: params[:id])
  end
end

