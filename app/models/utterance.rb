class Utterance < ActiveRecord::Base
  belongs_to :chat, :inverse_of => :utterances
end
