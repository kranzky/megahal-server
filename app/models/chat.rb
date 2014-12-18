class Chat < ActiveRecord::Base
  has_many :utterances
end
