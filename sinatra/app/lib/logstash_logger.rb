class LogstashLogger < Rack::CommonLogger
  private

  def log(env, status, header, began_at)
    now    = Time.now
    length = extract_content_length(header)
    logger = @logger || env['rack.errors']

    json = {
      '@timestamp' => now.utc.iso8601,
      '@fields'    => {
        'method'   => env['REQUEST_METHOD'],
        'path'     => env['PATH_INFO'],
        'status'   => status.to_s[0..3],
        'size'     => length,
        'duration' => now - began_at,
      }
    }

    logger.puts(json.to_json)
  end
end
