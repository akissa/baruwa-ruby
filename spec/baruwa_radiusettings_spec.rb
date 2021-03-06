require 'spec_helper'

describe 'Test RADIUS Settings' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get radius settings' do
        domainid = 10
        serverid = 10
        settingsid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/radiussettings/#{domainid}/#{serverid}/#{settingsid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_radiussettings(domainid, serverid, settingsid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/radiussettings/#{domainid}/#{serverid}/#{settingsid}")
    end

    it 'should create radius settings' do
        domainid = 10
        serverid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/radiussettings/#{domainid}/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_radiussettings(domainid, serverid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/radiussettings/#{domainid}/#{serverid}")
    end

    it 'should update radius settings' do
        domainid = 10
        serverid = 10
        settingsid = 10
        stub_request(:put, "https://testbaruwa.com/api/v1/radiussettings/#{domainid}/#{serverid}/#{settingsid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_radiussettings(domainid, serverid, settingsid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/radiussettings/#{domainid}/#{serverid}/#{settingsid}")
    end

    it 'should delete radius settings' do
        domainid = 10
        serverid = 10
        settingsid = 10
        stub_request(:delete, "https://testbaruwa.com/api/v1/radiussettings/#{domainid}/#{serverid}/#{settingsid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_radiussettings(domainid, serverid, settingsid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/radiussettings/#{domainid}/#{serverid}/#{settingsid}")
    end
end
