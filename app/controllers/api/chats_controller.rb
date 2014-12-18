module Api
  class ChatsController < ApplicationController
    protect_from_forgery :with => :null_session
    respond_to :json

    rescue_from StandardError, :with => :_server_error
    rescue_from ActionController::ParameterMissing, :with => :_bad_request

    def create
      @chat = Chat.new(params.permit(:user))
      if @chat.save
        render :show, :status => :created
      else
        render json: @chat.errors, :status => :unprocessable_entity
      end
    end

    private

    def _server_error(e)
      render json: ["dag nabbit"], :status => :internal_server_error
    end

    def _bad_request(e)
      render json: [e.message], :status => :bad_request
    end
  end
end
