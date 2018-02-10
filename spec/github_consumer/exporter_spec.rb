require 'spec_helper'

describe GithubConsumer::Exporter do
  describe '.save' do
    let(:dir) { "#{Dir.pwd}/spec/temp" }
    let(:file_name) { 'sample_file' }

    subject { described_class.save(headers, body, file_name, dir) }

    after { FileUtils.remove_dir(dir, true) }

    describe 'without headers' do
      let(:headers) { nil }
      let(:body) { [] }

      it { expect(subject[:status]).to be :error }
      it { expect(subject[:message]).to eq 'Can not save report status file' }
    end

    describe 'without body' do
      let(:headers) { GithubConsumer::DEFAULT_FILE_HEADERS }
      let(:body) { nil }

      it { expect(subject[:status]).to be :error }
      it { expect(subject[:message]).to eq 'Can not save report status file' }
    end

    describe 'with hearder and body' do
      let(:headers) { GithubConsumer::DEFAULT_FILE_HEADERS }
      let(:body) do
        [['Jhon', 'jhon@example.com', 'jhondoe', 'http://jhondoe.jpg', 10]]
      end

      it { expect(subject[:status]).to be :ok }
      it do
        expect(subject[:message]).to eq 'Report status file saved with success'
      end
    end
  end
end
