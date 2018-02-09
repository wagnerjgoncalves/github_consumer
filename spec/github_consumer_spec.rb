require "spec_helper"

describe GithubConsumer do
  it 'has a version number' do
    expect(GithubConsumer::VERSION).not_to be nil
  end

  describe '#fetch_commits' do
    let(:owner) { 'git' }
    let(:repository) { 'sample' }

     before do
      allow_any_instance_of(GithubConsumer::Http).to receive(:get).and_return(mock)
    end

    describe 'with a sucessfuly request' do
      let(:mock) { { status: :ok } }

      it { expect(described_class.fetch_commits(owner, repository)[:status]).to eq :ok }
    end

    describe 'with an unsucessfuly request' do
      let(:mock) { { status: :error } }

      it { expect(described_class.fetch_commits(owner, repository)[:status]).to eq :error }
    end
  end
end
