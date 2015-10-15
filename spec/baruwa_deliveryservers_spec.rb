require 'spec_helper'

describe 'Test Delivery servers' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get delivery servers' do
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/deliveryservers/#{domainid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_deliveryservers(domainid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/deliveryservers/#{domainid}")
    end

    it 'should get a delivery server' do
        domainid = 10
        serverid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/deliveryservers/#{domainid}/#{serverid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_deliveryserver(domainid, serverid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/deliveryservers/#{domainid}/#{serverid}")
    end

    it 'should create a delivery server' do
        domainid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/deliveryservers/#{domainid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_deliveryserver(domainid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/deliveryservers/#{domainid}")
    end

    it 'should update a delivery server' do
        domainid = 10
        serverid = 10
        stub_request(:put, "https://testbaruwa.com/api/v1/deliveryservers/#{domainid}/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_deliveryserver(domainid, serverid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/deliveryservers/#{domainid}/#{serverid}")
    end

    it 'should delete a delivery server' do
        domainid = 10
        serverid = 10
        stub_request(:delete, "https://testbaruwa.com/api/v1/deliveryservers/#{domainid}/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_deliveryserver(domainid, serverid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/deliveryservers/#{domainid}/#{serverid}")
    end
end
