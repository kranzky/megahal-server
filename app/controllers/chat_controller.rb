class ChatController < ApplicationController
  def index
  end

  def say
    name = params[:name]
    message = params[:message]
    response = "Why you say '#{message}'?"
    respond_to do |format|
      format.turbo_stream
    end
  end
end
