require 'dotenv/load'
require 'github_consumer/exporter'
require 'github_consumer/http'
require 'github_consumer/version'

module GithubConsumer
  DEFAULT_FILE_HEADERS = %w(name email login avatar_url commits_count).freeze

  module_function

  # Fetch commits from a specific repository of a owner and then,
  # export a txt file status report with all commiters ordered by total commits
  #
  # Example:
  #   >> GithubConsumer.stats_contributors(owner, repository)
  #
  # Arguments:
  #   owner: (String)
  #   repository: (String)
  def stats_contributors(owner, repository)
    response = Http.stats_contributors(owner, repository)

    return response if response[:status] == :error

    body = []
    file_name = "#{owner}_#{repository}"

    data = response[:data].sort_by { |item| item[:total] }.reverse
    data.each do |status_data|
      details = fetch_user_details(status_data[:author][:login])

      body << details + [status_data[:total]] unless details.empty?
    end

    Exporter.save(GithubConsumer::DEFAULT_FILE_HEADERS, body, file_name)
  end

  # Fetch user details by login
  #
  # Example:
  #   >> GithubConsumer.fetch_user_details(login)
  #
  # Arguments:
  #   login: (String)
  def fetch_user_details(login)
    details = Http.user_details(login)

    return [] if details[:status] == :error

    [
      details[:data][:name],
      details[:data][:email],
      details[:data][:login],
      details[:data][:avatar_url]
    ]
  end
end
