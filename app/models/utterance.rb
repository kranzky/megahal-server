class Utterance < ActiveRecord::Base
  belongs_to :chat

  validates_associated :chat
  validates_presence_of :chat
end
