require 'spec_helper'

describe GithubConsumer do
  it 'has a version number' do
    expect(GithubConsumer::VERSION).not_to be nil
  end

  describe '#stats_contributors' do
    let(:owner) { 'git' }
    let(:repository) { 'sample' }
    let(:stats_mock) do
      {
        status: :ok,
        data: [{
          author: { login: owner },
          total: 10
        }]
      }
    end

    before do
      allow(GithubConsumer::Http).to receive(:user_details).and_return(user_details_mock)
      allow(GithubConsumer::Http).to receive(:stats_contributors).and_return(stats_mock)
    end

    subject { GithubConsumer.stats_contributors(owner, repository) }

    describe 'with a sucessfuly request' do
      let(:user_details_mock) do
        {
          status: :ok,
          data: {
            name: 'Jhon Doe',
            email: 'jhondoe@example.com',
            login: 'jhondoe',
            avatar_url: 'http://jhondoe.jpg'
          }
        }
      end

      it { expect(subject[:status]).to eq :ok }
    end

    describe 'with an unsucessfuly request' do
      let(:user_details_mock) { { status: :error, message: 'Not Found' } }

      it { expect(subject[:status]).to eq :error }
    end
  end
end
