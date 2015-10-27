require 'spec_helper'

describe 'Test Exceptions' do
    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should raise an argument error' do
        ENDPOINT = {:name => '/status', :method => :patch}
        expect {@baruwapi.get_request(ENDPOINT, ENDPOINT[:name])}.to raise_error(ArgumentError)
    end

    it 'should raise an error' do
        stub_request(:get, "https://testbaruwa.com/api/v1/status").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 500, :body => "", :headers => {})
        expect {@baruwapi.get_status()}.to raise_error(StandardError)
    end
end
