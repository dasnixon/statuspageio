module Statuspageio
  class Client
    module Subscriber
      SUBSCRIBER_OPTIONS = %i(
        email
        endpoint
        phone_country
        phone_number
        skip_confirmation_notification
        page_access_user
        component_ids
      )

      def subscribers(incident_id: nil)
        if incident_id
          get("/pages/#{self.page_id}/incidents/#{incident_id}/subscribers")
        else
          get("/pages/#{self.page_id}/subscribers")
        end
      end

      def search_subscribers(q)
        return subscribers if q.nil? || q.empty?
        get("/pages/#{self.page_id}/subscribers", { q: q })
      end

      def create_subscriber(options)
        create_options = options.dup.slice(*SUBSCRIBER_OPTIONS)

        if valid_for_subscribing?(create_options)
          post("/pages/#{self.page_id}/subscribers", { subscriber: create_options })
        else
          raise ArgumentError, 'An email address or phone number with the two digit country code is required'
        end
      end

      def delete_subscriber(subscriber_id, incident_id: nil)
        if incident_id
          delete("/pages/#{self.page_id}/incidents/#{incident_id}/subscribers/#{subscriber_id}")
        else
          delete("/pages/#{self.page_id}/subscribers/#{subscriber_id}")
        end
      end

      private

      def valid_for_subscribing?(options)
        !(options[:email].empty? && (options[:phone_country].empty? || options[:phone_number].empty?))
      end
    end
  end
end
