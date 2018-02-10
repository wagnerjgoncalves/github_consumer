require 'net/http'
require 'uri'
require 'json'

module GithubConsumer
  class Http
    HOST = ENV['HOST']
    TOKEN = ENV['TOKEN']

    # Fetch GitHub contributos status
    #
    # Example:
    #   >> GithubConsumer::Http.stats_contributors(owner, repository)
    #
    # Arguments:
    #   owner: (String)
    #   repository: (String)
    def self.stats_contributors(owner, repository)
      url = "#{HOST}/repos/#{owner}/#{repository}/stats/contributors"

      get url
    end

    # Fetch GitHub user details
    #
    # Example:
    #   >> GithubConsumer::Http.user_details(login)
    #
    # Arguments:
    #   login: (String)
    def self.user_details(login)
      url = "#{HOST}/users/#{login}"

      get url
    end

    # Execute GET requests at a GitHub using TOKEN Authorization
    #
    # Example:
    #   >> GithubConsumer::Http.get(url)
    #
    # Arguments:
    #   url: (String)
    def self.get(url)
      authorization = { 'Authorization' => "token #{TOKEN}" }
      uri = URI(url)

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request Net::HTTP::Get.new uri, authorization
      end

      case response
      when Net::HTTPSuccess, Net::HTTPOK
        { status: :ok, data: JSON.parse(response.body, symbolize_names: true) }
      else
        { status: :error, message: response.message }
      end
    end
  end
end
