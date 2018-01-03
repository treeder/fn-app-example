require 'uri'
require 'net/http'
require 'json'

name = "I love rubies"

payload = STDIN.read
if payload != ""
    payload = JSON.parse(payload)
    name = payload['name']
end


def open(url)
    Net::HTTP.get(URI.parse(url))
end

reqURL = URI.parse(ENV['FN_REQUEST_URL'])
# would be nice to pass these in so we don't have to do all this parsing and what not. Or add to FDK's, eg: FN_APP_HOST, FN_APP_PATH_PREFIX
host = reqURL.host
if reqURL.host.include? "localhost"
    host = "docker.for.mac.localhost" 
    # todo: make this work on other platforms
end
    
pathPrefix = ""
if reqURL.path.start_with? "/r/"
    pathPrefix = "/r/#{ENV['FN_APP_NAME']}"
end
baseURL = "#{reqURL.scheme}://#{host}:#{reqURL.port}#{pathPrefix}"

header = open("#{baseURL}/header") 
puts header

puts "Hello, #{name}!"

footer = open("#{baseURL}/footer") 
puts footer
