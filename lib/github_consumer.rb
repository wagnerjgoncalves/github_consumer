require 'dotenv/load'
require 'github_consumer/version'
require 'github_consumer/http'

module GithubConsumer
  module_function

  # Fetch commits from a specific repository
  #
  # Example:
  #   >> GithubConsumer.fetch_commits(owner, repository)
  #
  # Arguments:
  #   owner: (String)
  #   repository: (String)
  def fetch_commits(owner, repository)
    Http.new(owner, repository).fetch_commits
  end
end
