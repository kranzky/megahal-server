class Chat < ActiveRecord::Base
  has_many :utterances

  validates_associated :utterances
end
