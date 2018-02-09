require 'net/http'
require 'uri'
require 'json'

class GithubConsumer::Http
  HOST = ENV['HOST']
  TOKEN = ENV['TOKEN']

  attr_reader :owner, :repository

  def initialize(owner, repository)
    @owner = owner
    @repository = repository
  end

  def fetch_commits
    url = "#{HOST}/repos/#{owner}/#{repository}/commits"

    get url
  end

  private

  def get(url)
    uri = URI(url)

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request Net::HTTP::Get.new uri, { 'Authorization' => "token #{TOKEN}" }
    end

    case response
    when Net::HTTPSuccess, Net::HTTPOK
      { status: :ok, data: JSON.parse(response.body) }
    else
      { status: :error, data: response.message }
    end
  end
end
