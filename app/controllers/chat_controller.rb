class ChatController < ApplicationController
  def index
  end

  def say
    @start = params[:start] == 'true'
    @name = params[:name]
    @message = params[:message]
    @response = @start ? "Hello #{@name}!" : "Why you say '#{@message}'?"
    respond_to do |format|
      format.turbo_stream
    end
  end
end
