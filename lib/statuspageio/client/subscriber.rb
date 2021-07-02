# frozen_string_literal: true

# https://developer.statuspage.io/#tag/subscribers
module Statuspageio
  class Client
    module Subscriber
      SUBSCRIBER_OPTIONS = %i[
        component_ids
        email
        endpoint
        page_access_user
        phone_country
        phone_number
        skip_confirmation_notification
      ].freeze

      def subscribers(incident_id: nil)
        if incident_id
          get("/pages/#{page_id}/incidents/#{incident_id}/subscribers")
        else
          get("/pages/#{page_id}/subscribers")
        end
      end

      def search_subscribers(query_str)
        return subscribers if query_str.nil? || query_str.empty?

        get("/pages/#{page_id}/subscribers", { q: query_str })
      end

      def create_subscriber(options)
        create_options = symbolize_keys(options).slice(*SUBSCRIBER_OPTIONS)

        if valid_for_subscribing?(create_options)
          post("/pages/#{page_id}/subscribers", { subscriber: create_options })
        else
          raise ArgumentError, 'An email address or phone number with the two digit country code '\
                               'is required'
        end
      end

      def delete_subscriber(subscriber_id, incident_id: nil)
        if incident_id
          delete("/pages/#{page_id}/incidents/#{incident_id}/subscribers/#{subscriber_id}")
        else
          delete("/pages/#{page_id}/subscribers/#{subscriber_id}")
        end
      end

      private

      def valid_for_subscribing?(options)
        !(options[:email].empty? &&
          (options[:phone_country].empty? || options[:phone_number].empty?))
      end
    end
  end
end
