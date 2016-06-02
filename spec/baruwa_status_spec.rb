require 'spec_helper'

describe 'Test System Status' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get system status' do
        stub_request(:get, "https://testbaruwa.com/api/v1/status").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_status()
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/status")
    end
end
