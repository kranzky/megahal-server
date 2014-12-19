module Api
  class InputsController < BaseController
    def create
      chat = Chat.find_by!(params.permit(:key))
      if chat.expired?
        render json: ["timed out"], :status => :gone
      elsif chat.busy?
        render json: ["waiting for reply"], :status => :method_not_allowed
      elsif chat.pending?
        render json: ["reply is ready"], :status => :method_not_allowed
      else
        @input = chat.input(params.permit(:text)[:text])
        render :show, :status => :created
      end
    end
  end
end
