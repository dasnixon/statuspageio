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

      def incidents(scope = :all, limit: 100, page: 1, query: nil)
        query_opts = { limit: limit, page: page, query: query }.compact

        if INCIDENT_TYPES.include?(scope&.to_s)
          return get("/pages/#{page_id}/incidents/#{scope}", query_opts)
        end

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
    end
  end
end
