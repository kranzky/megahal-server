class Job < ActiveRecord::Base
  has_one :chat
  belongs_to :utterance
end
