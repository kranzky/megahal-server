class MegahalController < ApplicationController
  def about
  end
  def chat
  end
  def transcripts
    @chats = Chat.paginate(page: params[:page], per_page: 10).order("created_at ASC")
  end
  def transcript
    @chat = Chat.find(params[:id])
  end
end
