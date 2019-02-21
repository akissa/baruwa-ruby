require 'spec_helper'

describe 'Test User Delivery servers' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get user delivery servers' do
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/userdeliveryservers/#{domainid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_user_deliveryservers(domainid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/userdeliveryservers/#{domainid}")
    end

    it 'should get user delivery servers with pagination' do
        page = 1
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/userdeliveryservers/#{domainid}?page=#{page}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_user_deliveryservers(domainid, page)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/userdeliveryservers/#{domainid}?page=#{page}")
    end

    it 'should get a user delivery server' do
        domainid = 10
        serverid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/userdeliveryservers/#{domainid}/#{serverid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_user_deliveryserver(domainid, serverid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/userdeliveryservers/#{domainid}/#{serverid}")
    end

    it 'should create a user delivery server' do
        domainid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/userdeliveryservers/#{domainid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_user_deliveryserver(domainid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/userdeliveryservers/#{domainid}")
    end

    it 'should update a user delivery server' do
        domainid = 10
        serverid = 10
        stub_request(:put, "https://testbaruwa.com/api/v1/userdeliveryservers/#{domainid}/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_user_deliveryserver(domainid, serverid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/userdeliveryservers/#{domainid}/#{serverid}")
    end

    it 'should delete a user delivery server' do
        domainid = 10
        serverid = 10
        stub_request(:delete, "https://testbaruwa.com/api/v1/userdeliveryservers/#{domainid}/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_user_deliveryserver(domainid, serverid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/userdeliveryservers/#{domainid}/#{serverid}")
    end
end
