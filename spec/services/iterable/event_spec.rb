require 'rails_helper'
require 'webmock'
RSpec.describe Iterable::Event do
    context "Create an event" do
        it 'when creating Event A in Iterable should not send any email notification' do
            # Setting up Iterable mock data and expectations
            stub_request(:post, 'https://api.iterable.com/api/events/trackWebPushClick')
            .with(
                body: {
                email: "testuser@gmail.com",
                campaignId: 0,
                }.to_json,
                headers: {
                'Api-Key' => Rails.application.credentials.iterable[:api_key],
                'Content-Type' => 'application/json',
                },
            )
            .to_return(status: 200, body: '{"code": "Success"}', headers: {})
            
            event_service = Iterable::Event.new
            expect(event_service).not_to receive(:send_email_notification)
            result = event_service.create("testuser@gmail.com", 'Event A')
            expect(result['code']).to eq("Success")
        end

        it 'when creating Event B in Iterable should send email notification' do
            # Setting up Iterable mock data and expectations
            stub_request(:post, 'https://api.iterable.com/api/events/trackWebPushClick')
            .with(
                body: {
                email: "testuser@gmail.com",
                campaignId: 0,
                }.to_json,
                headers: {
                'Api-Key' => Rails.application.credentials.iterable[:api_key],
                'Content-Type' => 'application/json',
                },
            )
            .to_return(status: 200, body: '{"code": "Success"}', headers: {})
            
            event_service = Iterable::Event.new
            expect(event_service).to receive(:send_email_notification)
            result = event_service.create("testuser@gmail.com", 'Event B')
            expect(result['code']).to eq("Success")
        end
    end
end