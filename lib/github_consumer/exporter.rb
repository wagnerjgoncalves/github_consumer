class GithubConsumer::Exporter
  # Export a file to a directory
  #
  # Example:
  #   >> GithubConsumer::Exporter.save(headers, body, file_name, dir)
  #
  # Arguments:
  #   headers: (Array) [name email login avatar_url commits_count]
  #   body: (Array) [['Jhon Doe', 'jhondoe@example.com', 'jhondoe', 'http://jhondoe.jpg', 10]]
  #   file_name: (String)
  #   dir: (String) default is tmp
  def self.save(headers, body, file_name, dir = './tmp')
    return false if headers.nil? || headers.empty?
    return false if body.nil? || body.empty?

    Dir.mkdir(dir) unless File.exists?(dir)

    File.open("#{dir}/#{file_name}_#{Time.new}.txt", 'w') do |file|
      file.write("#{headers.join(';')}\n")

      body.each { |row| file.write("#{row.join(';')}\n") }
    end

    true
  end
end
