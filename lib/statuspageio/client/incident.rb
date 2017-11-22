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
    end
  end
end
