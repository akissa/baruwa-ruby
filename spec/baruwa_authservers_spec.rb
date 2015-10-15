require 'spec_helper'

describe 'Test Authentication Settings' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get auth servers' do
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/authservers/#{domainid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_authservers(domainid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/authservers/#{domainid}")
    end

    it 'should get auth server' do
        domainid = 10
        serverid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/authservers/#{domainid}/#{serverid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_authserver(domainid, serverid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/authservers/#{domainid}/#{serverid}")
    end

    it 'should create an auth server' do
        domainid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/authservers/#{domainid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_authserver(domainid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/authservers/#{domainid}")
    end

    it 'should update an auth server' do
        domainid = 10
        serverid = 10
        stub_request(:put, "https://testbaruwa.com/api/v1/authservers/#{domainid}/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_authserver(domainid, serverid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/authservers/#{domainid}/#{serverid}")
    end

    it 'should delete an auth server' do
        domainid = 10
        serverid = 10
        stub_request(:delete, "https://testbaruwa.com/api/v1/authservers/#{domainid}/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI/Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_authserver(domainid, serverid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/authservers/#{domainid}/#{serverid}")
    end
end
