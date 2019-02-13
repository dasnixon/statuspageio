module Statuspageio
  class Client
    module Incident
      def incidents(scope = :all)
        case scope
        when :all
          get("/pages/#{self.page_id}/incidents")
        when :unresolved
          get("/pages/#{self.page_id}/incidents/unresolved")
        when :scheduled
          get("/pages/#{self.page_id}/incidents/scheduled")
        else
          get("/pages/#{self.page_id}/incidents")
        end
      end

      def search_incidents(q)
        return incidents if q.nil? || q.empty?
        get("/pages/#{self.page_id}/incidents", { q: q })
      end
    end
  end
end
