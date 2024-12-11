class TimeFormatter
  ALLOWED_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(params)
    @time_params = parse_formats(params)
  end

  def format
    validate_formats
    generate_formatted_time
  end

  private

  def parse_formats(query_string)
    Rack::Utils.parse_nested_query(query_string)['format']&.split(',') || []
  end

  def validate_formats
    unknown_formats = @time_params - ALLOWED_FORMATS.keys

    raise ArgumentError.new("unknown time format #{unknown_formats.join(', ')}") unless unknown_formats.empty?
  end

  def generate_formatted_time
    DateTime.now.strftime(ALLOWED_FORMATS.values_at(*@time_params).join('-'))
  end
end
