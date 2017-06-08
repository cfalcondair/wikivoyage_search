# myapp.rb
require 'sinatra'

$LOAD_PATH.unshift(__dir__)
require 'main'
require 'json'

set :bind, '0.0.0.0'

post '/' do
  if params['query'].nil?
    return "Must pass query parameter"
  end

  unless params['query'].is_a?(String)
    return "query must be a string"
  end
  result = Query.new.run(params['query'])
  result.to_json
end
