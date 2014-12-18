class Utterance < ActiveRecord::Base
  has_one :job
  belongs_to :chat, :inverse_of => :utterances
end
