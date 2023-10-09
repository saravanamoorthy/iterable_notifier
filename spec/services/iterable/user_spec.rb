require 'rails_helper'
require 'webmock'
RSpec.describe Iterable::User do
    context "when creating user with valid params" do
        let(:user) { User.new(first_name: "Saravana", last_name: "Moorthy", phone: "9876543210", email: "testuser@gmail.com") }
        
        it 'should respond with success' do
            # Setting up Iterable mock data and expectations
            stub_request(:post, 'https://api.iterable.com/api/users/update')
            .with(
                body: { 
                    email: user.email,
                    dataFields: {
                    first_name: user.first_name, last_name: user.last_name
                    }
                }.to_json,
                headers: {
                'Api-Key' => Rails.application.credentials.iterable[:api_key],
                'Content-Type' => 'application/json',
                },
            )
            .to_return(status: 200, body: '{"code": "Success"}', headers: {})
            
            result = Iterable::User.create(user)
            
            expect(result['code']).to eq("Success")
        end
    end
end