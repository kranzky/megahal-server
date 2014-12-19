require 'securerandom'

class Chat < ActiveRecord::Base
  has_many :utterances
  belongs_to :job

  before_create :_generate_key
  after_create :_generate_greeting

  def input(text)
    raise if busy? || pending? || expired?
    ActiveRecord::Base.transaction do
      input = Input.new(text: text)
      self.utterances << input
      self.job = Job.new(utterance: input)
      self.touch
      self.save!
      return input
    end
  end

  def reply(text)
    raise unless busy?
    ActiveRecord::Base.transaction do
      reply = Reply.new(text: text)
      self.utterances << reply
      self.job.utterance = reply
      self.job.save!
      self.touch
      self.save!
      return reply
    end
  end

  def ack
    raise unless pending?
    ActiveRecord::Base.transaction do
      reply = self.job.utterance
      completed_job = self.job
      self.job = nil
      completed_job.chat = nil
      completed_job.utterance = nil
      completed_job.destroy
      return reply
    end
  end

  def busy?
    self.job.present? && (self.job.utterance.nil? || self.job.utterance.is_a?(Input))
  end

  def pending?
    self.job.present? && self.job.utterance.is_a?(Reply)
  end

  def expired?
    !busy? && !pending? && self.updated_at < 20.minutes.ago
  end

  private

  def _generate_key
    self.key = SecureRandom.uuid
  end

  def _generate_greeting
    ActiveRecord::Base.transaction do
      self.job = Job.new
      self.touch
      self.save!
    end
  end
end
