require 'uri'

reqURL = URI.parse(ENV['FN_REQUEST_URL'])    
pathPrefix = ""
if reqURL.path.start_with? "/r/"
    pathPrefix = "/r/#{ENV['FN_APP_NAME']}"
end
baseURL = "#{reqURL.scheme}://#{reqURL.host}:#{reqURL.port}#{pathPrefix}"

puts %{
    <div style="margin-top: 20px; border-top: 1px solid gray;">
        <div><a href="#{pathPrefix}/ruby">Ruby</a></div>
        <div><a href="#{pathPrefix}/node">Node</a></div>
        <div><a href="#{pathPrefix}/python">Python</a></div>
    </div>
  </body>
</html>
}
