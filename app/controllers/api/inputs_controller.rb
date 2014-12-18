module Api
  class InputsController < ApplicationController
    protect_from_forgery :with => :null_session
    respond_to :json

    rescue_from ActionController::ParameterMissing, :with => :_bad_request
    rescue_from ActiveRecord::RecordNotFound, :with => :_not_found

    def create
      chat = Chat.find_by!(params.permit(:key))
      if chat.expired?
        render json: ["chat has timed out"], :status => :gone
      elsif chat.busy?
        render json: ["reply is pending"], :status => :method_not_allowed
      else
        @input = chat.input(params.permit(:text)[:text])
        render :show, :status => :created
      end
    end

    private

    def _bad_request(e)
      render json: [e.message], :status => :bad_request
    end

    def _not_found(e)
      render json: [e.message], :status => :not_found
    end
  end
end
