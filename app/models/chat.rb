require 'securerandom'

class Chat < ActiveRecord::Base
  has_many :utterances
  belongs_to :job

  before_create :_generate_key
  after_create :_generate_greeting

  def input(text)
    ActiveRecord::Base.transaction do
      input = Input.new(text: text)
      self.utterances << input
      self.job = Job.new(utterance: input)
      self.touch
      self.save
      return input
    end
  end

  def reply(text)
    ActiveRecord::Base.transaction do
      reply = Reply.new(text: text)
      self.utterances << reply
      if job = self.job
        self.job = nil
        job.chat = nil
        job.utterance = nil
        job.destroy
      end
      self.touch
      self.save
      return reply
    end
  end

  def last_reply
    self.utterances.where(type: Reply).last
  end

  def expired?
    !busy? && self.updated_at < 20.minutes.ago
  end

  def busy?
    self.job.present?
  end

  private

  def _generate_key
    self.key = SecureRandom.uuid
  end

  def _generate_greeting
    self.job = Job.new
    self.save
  end
end
