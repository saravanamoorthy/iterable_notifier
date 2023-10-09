module Iterable
    class Base
        include HTTParty
        base_uri Rails.application.credentials.iterable[:base_url]

        def initialize()
            @options = {
                headers: {
                    'Content-Type' => 'application/json',
                    'Api-Key' => Rails.application.credentials.iterable[:api_key]
                }
            }
        end

        def send_email_notification(user_email, event_name)
            response = self.class.post('/email/target', @options.merge(body: { 
                campaignId: 0,
                recipientEmail: user_email
            }.to_json))
            handle_response(response)
        end

        private

        def handle_response(response)
            if response.success?
                JSON.parse(response.body)
            else
                raise "Iterable API Error: #{response.msg}"
            end
        end
    end
end