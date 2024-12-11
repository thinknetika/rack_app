
class App
  def call(env)
    time_formatter = TimeFormatter.new(env['QUERY_STRING'])
    body = {'content-type' => 'text/plain'}

    if env['REQUEST_PATH'] == '/time'
      begin
        response = [200, body, [time_formatter.format]]
      rescue ArgumentError => e
        response = [400, body, [e.message]]
      end
      response
    else
      [404, body, ['Not Found']]
    end
  end
end
