## Web Reverse Proxy Rails5

This project is a dead simple reverse proxy built in rails.

It allows you to send a request to your own server, which sends a request to a domain of your choice, and returns the response through your server. It gives you anonymity and a platform to alter the response with rack/rails.

Note: This app can only sends requests to 1 domain, which you specify as an environment variable. For more flexibility see the [rack-reverse-proxy](https://github.com/waterlink/rack-reverse-proxy) gem.

### Getting Started

Clone the repo, run `$ bundle install` to install the gems.

Add the `PROXY_DOMAIN` you want to send requests to. In your development environment, create a `.env` file in your project folder and add the `PROXY_DOMAIN` there.

`.env` file example
```
PROXY_DOMAIN="https://twitter.com"
```

If you're running the app in production, make sure to set the environment variable, the `.env` gem is not configured for production.

Run the rails app with `$ rails s`.

Now `http://locahost:3000` will show `https://twitter.com` and all the links will work.

#### Injection
for the basic localhost example, `INJECT_DOMAIN` is an environment variable for .

### Undesired Behavior
* Redirects. The Location header is not modified, so a redirect will redirect you the original domain.
* Absolute links. Relative links work fine, but absolute links do not. Most websites have relative links these days thankfully.
