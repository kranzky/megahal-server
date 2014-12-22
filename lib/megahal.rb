class MegaHAL
  def self.instance
    @@_instance ||= MegaHAL.new
  end

  def self.init
    Rails.logger.info "[MH] Started Init"
    # TODO: load brain if present, clear if otherwise
    Rails.logger.info "[MH] Stopped Init"
  end
  
  def self.process
    unless job = _get_job
      # TODO: save brain
      sleep(2)
      return
    end
    job.chat.reply(instance.reply(job.utterance.try(:text)))
    Rails.logger.info "[MH] Processed Job"
  end

  private

  def self._get_job
    Job.where(utterance: nil).first || Job.joins(:utterance).merge(Utterance.where(type: Input)).first
  end
end
