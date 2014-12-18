require 'securerandom'

class Chat < ActiveRecord::Base
  has_many :utterances

  validates_associated :utterances

  before_create :_generate_key

  private

  def _generate_key
    self.key = SecureRandom.uuid
  end
end
