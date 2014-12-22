require 'fileutils'

class MegaHAL
  def self.instance
    @@_instance ||= MegaHAL.new
  end

  def self.init(dir = nil)
    Rails.logger.info "[MH] Started Init"
    @@_dir = dir || Dir.getwd
    @@_dirty = false
    @@_checkpoint = Time.now
    source = File.join(@@_dir, "megahal.brn")
    if File.exists?(source)
      instance.load(source)
      Rails.logger.info "[MH] Loaded Brain"
    else
      instance.clear
      Rails.logger.info "[MH] Cleared Brain"
    end
    Rails.logger.info "[MH] Stopped Init"
  end
  
  def self.process
    unless job = _get_job
      if @@_dirty && (Time.now - @@_checkpoint > 1.hour)
        @@_dirty = false
        @@_checkpoint = Time.now
        source = File.join(@@_dir, "megahal.brn")
        if File.exists?(source)
          dest = File.join(@@_dir, "megahal_#{@@_checkpoint.strftime("%Y%m%d%H%M%S")}.brn")
          FileUtils.mv(source, dest, force: true)
        end
        instance.save(source)
        Rails.logger.info "[MH] Saved Brain"
      end
      sleep(0.2)
      return
    end
    @@_dirty = true
    job.chat.reply(instance.reply(job.utterance.try(:text)))
    Rails.logger.info "[MH] Processed Job"
  end

  private

  def self._get_job
    Job.where(utterance: nil).first || Job.joins(:utterance).merge(Utterance.where(type: Input)).first
  end
end
