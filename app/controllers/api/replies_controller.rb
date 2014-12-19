module Api
  class RepliesController < BaseController
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
  end
end
