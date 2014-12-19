module Api
  class RepliesController < ApplicationController
    protect_from_forgery :with => :null_session
    respond_to :json

    rescue_from StandardError, :with => :_server_error
    rescue_from ActionController::ParameterMissing, :with => :_bad_request
    rescue_from ActiveRecord::RecordNotFound, :with => :_not_found

    def create
      chat = Chat.find_by!(params.permit(:key))
      if chat.expired?
        render json: ["timed out"], :status => :gone
      elsif chat.busy?
        render json: ["waiting for reply"], :status => :method_not_allowed
      elsif !chat.pending?
        render json: ["waiting for input"], :status => :method_not_allowed
      else
        @reply = chat.ack
        render :show, :status => :created
      end
    end

    private

    def _server_error(e)
      render json: ["dag nabbit"], :status => :internal_server_error
    end

    def _bad_request(e)
      render json: [e.message], :status => :bad_request
    end

    def _not_found(e)
      render json: [e.message], :status => :not_found
    end
  end
end
