module Caching
  private def caching(key, &block)
    redis = Redis::Client.new
    cached = redis.get("#{@repo.cache_key}/#{key.downcase}")
    return cached unless cached.nil?
    data = yield
    redis.set("#{@repo.cache_key}/#{key.downcase}", data)
    data
  end
end
