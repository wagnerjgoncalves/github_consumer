require "spec_helper"

describe GithubConsumer::Exporter do
  describe '.save' do
    let(:dir) { "#{Dir.pwd}/spec/temp" }
    let(:file_name) { "sample_file" }

    subject { described_class.save(headers, body, file_name, dir) }

    after { FileUtils.remove_dir(dir, true) }

    describe 'without headers' do
      let(:headers) { nil }
      let(:body) { [] }

      it { expect(subject).to be false }
    end

    describe 'without body' do
      let(:headers) { %w[name email login avatar_url commits_count] }
      let(:body) { nil }

      it { expect(subject).to be false }
    end

    describe 'with hearder and body' do
      let(:headers) { %w[name email login avatar_url commits_count] }
      let(:body) do
        [['Jhon Doe', 'jhondoe@example.com', 'jhondoe', 'http://jhondoe.jpg', 10]]
      end

      it { expect(subject).to be true }
    end
  end
end
