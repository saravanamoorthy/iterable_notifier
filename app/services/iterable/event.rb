module Iterable
    class Event < Base

        def self.create(user_email, name)
            new.create(user_email, name)
        end

        def create(user_email, name)
            response = self.class.post('/events/trackWebPushClick', @options.merge(body: { email: user_email, campaignId: 0 }.to_json))
            if name == 'Event B'
                send_email_notification(user_email, name)
            end
            handle_response(response)
        end
    end
end