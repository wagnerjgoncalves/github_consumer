module GithubConsumer
  class Exporter
    ERROR_MESSAGE = {
      status: :error,
      message: 'Can not save report status file'
    }.freeze
    SUCCESS_MESSAGE = {
      status: :ok,
      message: 'Report status file saved with success'
    }.freeze

    # Export a file to a directory
    #
    # Example:
    #   >> GithubConsumer::Exporter.save(headers, body, file_name, dir)
    #
    # Arguments:
    #   headers: (Array) [name email login avatar_url commits_count]
    #   body: (Array) [['Jhon', 'jhon@example', 'jhon', 'http://jhon.jpg', 1]]
    #   file_name: (String)
    #   dir: (String) default is tmp
    def self.save(headers, body, file_name, dir = './tmp')
      return ERROR_MESSAGE if headers.nil? || headers.empty?
      return ERROR_MESSAGE if body.nil? || body.empty?

      Dir.mkdir(dir) unless File.exist?(dir)

      File.open("#{dir}/#{file_name}_#{Time.new}.txt", 'w') do |file|
        file.write("#{headers.join(';')}\n")

        body.each { |row| file.write("#{row.join(';')}\n") }
      end

      SUCCESS_MESSAGE
    end
  end
end
