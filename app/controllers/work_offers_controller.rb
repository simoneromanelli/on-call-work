class WorkOffersController < RestrictedController

  def_param_group :work_offer do
    param :work_offer, Hash, required: true do
      param :title, String, 'Title', required: true
      param :description, String, 'Work offer description.', required: true
      param :date_time, String, 'Date of the work offer.', required: true
      param :company_name, String, 'Name of the company.', required: true
      param :elected_id, Integer, 'Id of the choosen employee.', required: false
      param :bidder_id, Integer,
            desc: 'id of the user that create the work_offer.', required: true
    end
  end

  before_action :set_work_offer, only: [:show, :update, :destroy]

  api! 'List of the future work offers'
  def index
    authorize WorkOffer
    @work_offers = WorkOffer.all

    render json: @work_offers
  end

  api! 'show the work offer'
  param :id, Integer, 'id of the work offer'
  def show
    authorize @work_offer
    render json: @work_offer
  end

  api! 'Create a work offer'
  param_group :work_offer
  def create
    @work_offer = WorkOffer.new(work_offer_params)
    authorize @work_offer

    if @work_offer.save
      render json: @work_offer, status: :created, location: @work_offer
    else
      render json: { errors: @work_offer.errors.full_messages },
             status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  api! 'Update a work offer'
  param_group :work_offer
  def update
    authorize @work_offer

    if @work_offer.update(work_offer_params)
      render json: @work_offer, status: :ok, location: @work_offer
    else
      render json: { errors: @work_offer.errors }, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  api! 'Delete a work offer'
  param :id, Integer, 'id of the work offer'
  def destroy
    authorize @work_offer
    @work_offer.destroy
    render status: :ok, nothing: true
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  private

    def set_work_offer
      @work_offer = WorkOffer.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { 'errors': ['Unknown work offer'] }
    end

    def work_offer_params
      params.require(:work_offer).permit(:title, :description, :company_name, :date_time, :bidder_id, :elected_id)
    end
end
