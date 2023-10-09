module Iterable
    class User < Base

        def self.create(user)
            new.create(user)
        end

        def create(user)
            # In Iterable service create and update using same API endpoint  
            update(user)
        end

        def update(user)
            response = self.class.post('/users/update', @options.merge(body: { email: user.email, dataFields: {first_name: user.first_name, last_name: user.last_name} }.to_json))
            handle_response(response)
        end
    end
end