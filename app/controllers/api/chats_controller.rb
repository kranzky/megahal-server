module Api
  class ChatsController < BaseController
    def create
      @chat = Chat.new(params.permit(:user))
      if @chat.save
        render :show, :status => :created
      else
        render json: @chat.errors, :status => :unprocessable_entity
      end
    end
  end
end
