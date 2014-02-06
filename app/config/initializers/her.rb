# Configure Her
Her::API.setup :url => "http://localhost:3001/api/v1" do |c|
  c.use Faraday::Request::UrlEncoded
  c.use Her::Middleware::DefaultParseJSON
  c.use Faraday::Response::Logger, $logger
  c.use Faraday::Adapter::NetHttp
end