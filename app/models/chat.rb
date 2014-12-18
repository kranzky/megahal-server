require 'securerandom'

class Chat < ActiveRecord::Base
  has_many :utterances
  belongs_to :job

  before_create :_generate_key

  def input(text)
    input = Input.new(text: text)
    self.utterances << input
    self.job = Job.new(utterance: input)
    self.save
    return input
  end

  def expired?
    self.updated_at < 20.minutes.ago
  end

  def busy?
    return false unless reply = self.utterances.last
    reply === Input || reply.text.nil?
  end

  private

  def _generate_key
    self.key = SecureRandom.uuid
  end
end
