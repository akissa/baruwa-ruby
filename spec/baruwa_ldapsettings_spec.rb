require 'spec_helper'

describe 'Test AD/LDAP Settings' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get ldap settings' do
        domainid = 10
        serverid = 10
        settingsid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/ldapsettings/#{domainid}/#{serverid}/#{settingsid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_ldapsettings(domainid, serverid, settingsid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/ldapsettings/#{domainid}/#{serverid}/#{settingsid}")
    end

    it 'should create ldap settings' do
        domainid = 10
        serverid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/ldapsettings/#{domainid}/#{serverid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_ldapsettings(domainid, serverid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/ldapsettings/#{domainid}/#{serverid}")
    end

    it 'should update ldap settings' do
        domainid = 10
        serverid = 10
        settingsid = 10
        stub_request(:put, "https://testbaruwa.com/api/v1/ldapsettings/#{domainid}/#{serverid}/#{settingsid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_ldapsettings(domainid, serverid, settingsid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/ldapsettings/#{domainid}/#{serverid}/#{settingsid}")
    end

    it 'should delete ldap settings' do
        domainid = 10
        serverid = 10
        settingsid = 10
        stub_request(:delete, "https://testbaruwa.com/api/v1/ldapsettings/#{domainid}/#{serverid}/#{settingsid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_ldapsettings(domainid, serverid, settingsid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/ldapsettings/#{domainid}/#{serverid}/#{settingsid}")
    end
end
