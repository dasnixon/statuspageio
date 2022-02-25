# frozen_string_literal: true

# https://developer.statuspage.io/#tag/incidents
module Statuspageio
  class Client
    module Incident
      extend Gem::Deprecate

      INCIDENT_TYPES = %w[
        active_maintenance
        scheduled
        unresolved
        upcoming
      ].freeze

      VALID_INCIDENT_OPTIONS = %i[
        auto_transition_deliver_notifications_at_end
        auto_transition_deliver_notifications_at_start
        auto_transition_to_maintenance_state
        auto_transition_to_operational_state
        auto_tweet_at_beginning
        auto_tweet_on_completion
        auto_tweet_on_creation
        auto_tweet_one_hour_before
        backfill_date
        backfilled
        body
        components
        component_ids
        deliver_notifications
        impact_override
        metadata
        name
        status
        scheduled_auto_completed
        scheduled_auto_transition
        scheduled_auto_in_progress
        scheduled_for
        scheduled_remind_prior
        scheduled_until
      ].freeze

      def incidents(scope = :all, limit: 100, page: 1, query: nil)
        query_opts = { limit: limit, page: page, query: query }.compact

        return get("/pages/#{page_id}/incidents/#{scope}", query_opts) if INCIDENT_TYPES.include?(scope&.to_s)

        get("/pages/#{page_id}/incidents", query_opts)
      end

      def incident(incident_id)
        get("/pages/#{page_id}/incidents/#{incident_id}")
      end

      def search_incidents(query)
        incidents(query: query)
      end

      deprecate :search_incidents, :incidents, 2021, 7

      def delete_incident(incident_id)
        delete("/pages/#{page_id}/incidents/#{incident_id}")
      end

      def create_incident(opts = {})
        create_opts = allowlist_opts(symbolize_keys(opts))

        raise ArgumentError, 'name is required' if create_opts[:name].nil? || create_opts[:name].empty?

        post("/pages/#{page_id}/incidents", incident: create_opts)
      end

      def update_incident(incident_id, opts = {})
        update_opts = allowlist_opts(symbolize_keys(opts))

        put("/pages/#{page_id}/incidents/#{incident_id}", incident: update_opts)
      end

      private

      def allowlist_opts(opts)
        opts.slice(*VALID_INCIDENT_OPTIONS)
      end
    end
  end
end
