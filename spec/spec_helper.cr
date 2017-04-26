require "spec2"
require "webmock"
require "../src/mastodon"

include Spec2::GlobalDSL
Spec2.doc

def fixture_image(name)
  File.dirname(__FILE__) + "/fixtures/#{name}"
end

def load_fixture(name)
  File.read_lines(File.dirname(__FILE__) + "/fixtures/#{name}.json").join("\n")
end

def client
  Mastodon::REST::Client.new("example.com", "token")
end

# GET
def stub_get(path, fixture, query = "")
  query = "?#{query}" unless query.empty?
  WebMock.stub(:get, "https://#{client.url}#{path}#{query}").
    with(headers: {"Authorization" => "Bearer token"}).
    to_return(body: load_fixture(fixture))
end

# POST
def stub_post(path, fixture, body = "")
  WebMock.stub(:post, "https://#{client.url}#{path}").
    with(body: body, headers: {"Content-type" => "application/x-www-form-urlencoded", "Authorization" => "Bearer token"}).
    to_return(body: load_fixture(fixture))
end

def stub_post_no_return(path, body = "")
  WebMock.stub(:post, "https://#{client.url}#{path}").
    with(body: body, headers: {"Content-type" => "application/x-www-form-urlencoded", "Authorization" => "Bearer token"}).
    to_return(body: "{}")
end
