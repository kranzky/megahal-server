class ChatController < ApplicationController
  before_action :_set_redis, only: [:say]

  def index
  end

  def say
    @start = params[:start] == 'true'
    @name = params[:name]
    @message = params[:message]
    @response = _megahal
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def _megahal
    epoch = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    key = "megahal-message:#{SecureRandom.uuid}"
    data = { time: Time.now.to_f, name: @name, message: @message }
    @redis.set(key, data.to_json)
    key.gsub!("-message:", "-reply:")
    while Process.clock_gettime(Process::CLOCK_MONOTONIC) - epoch < 10
      reply = @redis.getdel(key)
      return reply if reply.present?
      sleep 0.1
    end
    key.gsub!("-reply:", "-message:")
    @redis.del(key)
    return "[TIMEOUT]"
  end

  def _set_redis
    @redis = Redis.new(url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" })
  end
end
