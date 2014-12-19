class MegaHAL
  def self.instance
    @@_instance ||= MegaHAL.new
  end

  def self.init
    Rails.logger.info "[MH] Started Init"
    instance.clear
    Rails.logger.info "[MH] Stopped Init"
  end
  
  def self.process
    Rails.logger.info "[MH] did something..."
    # megahal.reply(nil)
    # megahal.reply(input)
    # megahal.load(filename)
    # megahal.save(filename)
    sleep(5)
  end
end
