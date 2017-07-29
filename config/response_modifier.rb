class ResponseModifier
  def initialize(app = nil)
    puts "ResponseModifier initialize"
    @app = app || -> _ { [404, {}, []] }
  end
  def call(env)
    puts "ResponseModifier call"
    # resp = @app.call(env)
    status, headers, response = @app.call(env)
    puts "=============="
    puts env["PATH_INFO"]
    if env["PATH_INFO"].match(/\/wiki\/.+/) # if its a wiki url
      puts response
    end
    # resp[1]["X-Frame-Options"] = "ALLOW"
    # resp

    new_response = self.class.addScript(response.body.to_s)
    # also must reset the Content-Length header if changing body
    headers['Content-Length'] = new_response.length.to_s
    [status, headers, [new_response]]
  end

  def self.addScript bodyString
    newBodyString = bodyString.gsub("</body>", "<script type=\"text/javascript\" src=\"http://localhost:3000/wikipedia.js\"></script></body>")
    # bodyString = "<html><head></head><body><h1 id=\"test-div\">Hello David</h1><script type=\"text/javascript\">document.getElementById('test-div').innerHTML = 'testsets'</script></body>"
    newBodyString
  end
end
