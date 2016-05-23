require 'spec_helper'

describe 'Test Fallback servers' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get Fallback servers' do
        orgid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/fallbackservers/list/#{orgid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_fallbackservers(orgid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/fallbackservers/list/#{orgid}")
    end

    it 'should get a Fallback server' do
        serverid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/fallbackservers/#{serverid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_fallbackserver(serverid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/fallbackservers/#{serverid}")
    end

    it 'should create a Fallback server' do
        orgid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/fallbackservers/#{orgid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_fallbackserver(orgid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/fallbackservers/#{orgid}")
    end

    it 'should update a Fallback server' do
        serverid = 10
        stub_request(:put, "https://testbaruwa.com/api/v1/fallbackservers/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_fallbackserver(serverid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/fallbackservers/#{serverid}")
    end

    it 'should delete a Fallback server' do
        serverid = 10
        stub_request(:delete, "https://testbaruwa.com/api/v1/fallbackservers/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_fallbackserver(serverid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/fallbackservers/#{serverid}")
    end
end
