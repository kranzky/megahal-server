class ChatController < ApplicationController
  def index
  end

  def say
    @name = params[:name]
    @message = params[:message]
    if @message.present?
      @response = "Why you say '#{@message}'?"
    else
      @response = "Hello #{@name}!" 
    end
    @message = "..." if @message&.length == 0
    respond_to do |format|
      format.turbo_stream
    end
  end
end
