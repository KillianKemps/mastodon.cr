require "spec2"
require "webmock"
require "../src/mastodon"

include Spec2::GlobalDSL
Spec2.doc

# Utils
def fixture_image(name)
  File.dirname(__FILE__) + "/fixtures/#{name}"
end

def load_fixture(name)
  File.read_lines(File.dirname(__FILE__) + "/fixtures/#{name}.json").join("\n")
end

# GET
def stub_get(path, fixture, query = "")
  query = "?#{query}" unless query.empty?
  WebMock.stub(:get, "https://example.com#{path}#{query}").
    with(headers: {
      "Authorization" => "Bearer token",
      "User-Agent" => "mastodon.cr/#{Mastodon::VERSION}"
    }).
    to_return(body: load_fixture(fixture))
end

# POST
def stub_post(path, fixture = nil, body = "")
  response_body = fixture.nil? ? "{}" : load_fixture(fixture)
  WebMock.stub(:post, "https://example.com#{path}").
    with(body: body, headers: {
      "Content-type" => "application/x-www-form-urlencoded",
      "Authorization" => "Bearer token",
      "User-Agent" => "mastodon.cr/#{Mastodon::VERSION}"
    }).
    to_return(body: response_body)
end
