describe Statuspageio::Client::Incident do
  let(:client) { Statuspageio::Client.new(api_key: api_key, page_id: page_id) }

  let(:api_key) { 'api_key' }
  let(:page_id) { '1' }

  describe '#incidents' do
    let(:body) do
      load_fixture('incidents')
    end

    let(:base_request_url) { "https://api.statuspage.io/v1/pages/#{page_id}/incidents" }

    context 'fetching all incidents' do
      before do
        stub_request(:get, "#{base_request_url}.json?limit=100&page=1").
          to_return(body: body, status: 200)
      end

      it 'fetches incidents' do
        expect(client.incidents.length).to eq(1)
      end
    end

    context 'pagination' do
      before do
        stub_request(:get, "#{base_request_url}.json?limit=10&page=2").
          to_return(body: body, status: 200)
      end

      it 'supports page and limit query params' do
        expect(client.incidents(limit: 10, page: 2).length).to eq(1)
      end
    end

    context 'querying' do
      before do
        stub_request(:get, "#{base_request_url}.json?limit=100&page=1&query=api").
          to_return(body: body, status: 200)
      end

      it 'supports page and limit query params' do
        expect(client.incidents(query: 'api').length).to eq(1)
      end

      context 'empty query str' do
        before do
          stub_request(:get, "#{base_request_url}.json?limit=100&page=1").
            to_return(body: body, status: 200)
        end

        it 'fetches all incidents' do
          expect(client.incidents.length).to eq(1)
        end
      end
    end

    context 'active_maintenance scope' do
      before do
        stub_request(:get, "#{base_request_url}/active_maintenance.json?limit=100&page=1").
          to_return(body: body, status: 200)
      end

      it "fetches 'active_maintenance' incidents" do
        expect(client.incidents(:active_maintenance).length).to eq(1)
      end
    end

    context 'scheduled scope' do
      before do
        stub_request(:get, "#{base_request_url}/scheduled.json?limit=100&page=1").
          to_return(body: body, status: 200)
      end

      it "fetches 'scheduled' incidents" do
        expect(client.incidents(:scheduled).length).to eq(1)
      end
    end

    context 'unresolved scope' do
      before do
        stub_request(:get, "#{base_request_url}/unresolved.json?limit=100&page=1").
          to_return(body: body, status: 200)
      end

      it "fetches 'unresolved' incidents" do
        expect(client.incidents(:unresolved).length).to eq(1)
      end
    end

    context 'upcoming scope' do
      before do
        stub_request(:get, "#{base_request_url}/upcoming.json?limit=100&page=1").
          to_return(body: body, status: 200)
      end

      it "fetches 'upcoming' incidents" do
        expect(client.incidents(:upcoming).length).to eq(1)
      end
    end

    context 'passing an invalid scope' do
      before do
        stub_request(:get, "#{base_request_url}.json?limit=100&page=1").
          to_return(body: body, status: 200)
      end

      it 'fetches all incidents' do
        expect(client.incidents(:not_a_real_scope).length).to eq(1)
      end
    end
  end

  describe '#incident' do
    let(:body) do
      load_fixture('incident')
    end

    let(:incident_id) { '2220srj7t3zp' }

    let(:request_url) do
      "https://api.statuspage.io/v1/pages/#{page_id}/incidents/#{incident_id}.json"
    end

    before do
      stub_request(:get, request_url).
        to_return(body: body, status: 200)
    end

    it 'fetches an incident' do
      incident = client.incident(incident_id)

      expect(incident['id']).to eq(incident_id)
    end
  end

  describe '#search_incidents' do
    let(:base_request_url) { "https://api.statuspage.io/v1/pages/#{page_id}/incidents" }

    let(:body) do
      load_fixture('incidents')
    end

    context 'empty query str' do
      before do
        stub_request(:get, "#{base_request_url}.json?limit=100&page=1").
          to_return(body: body, status: 200)
      end

      it 'fetches all incidents' do
        expect(client.search_incidents(nil).length).to eq(1)
      end
    end

    context 'with a query str' do
      before do
        stub_request(:get, "#{base_request_url}.json?limit=100&page=1&query=api").
          to_return(body: body, status: 200)
      end

      it 'fetches all incidents' do
        expect(client.search_incidents('api').length).to eq(1)
      end
    end
  end

  describe '#delete_incident' do
    let(:body) do
      load_fixture('incident')
    end

    let(:incident_id) { '2220srj7t3zp' }

    let(:request_url) do
      "https://api.statuspage.io/v1/pages/#{page_id}/incidents/#{incident_id}.json"
    end

    before do
      stub_request(:delete, request_url).
        to_return(body: body, status: 200)
    end

    it 'fetches an incident' do
      expect(client.delete_incident(incident_id)).to_not be_empty
    end
  end
end
