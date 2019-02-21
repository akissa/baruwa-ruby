require 'spec_helper'

describe 'Test Domain Aliases' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get domain aliases' do
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/domainaliases/#{domainid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_domainaliases(domainid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domainaliases/#{domainid}")
    end

    it 'should get domain aliases with pagination' do
        page = 1
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/domainaliases/#{domainid}?page=#{page}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_domainaliases(domainid, page)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domainaliases/#{domainid}?page=#{page}")
    end

    it 'should get a domain alias' do
        domainid = 10
        aliasid = 1
        stub_request(:get, "https://testbaruwa.com/api/v1/domainaliases/#{domainid}/#{aliasid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_domainalias(domainid, aliasid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domainaliases/#{domainid}/#{aliasid}")
    end

    it 'should create a domain alias' do
        domainid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/domainaliases/#{domainid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_domainalias(domainid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domainaliases/#{domainid}")
    end

    it 'should update a domain alias' do
        domainid = 10
        aliasid = 1
        stub_request(:put, "https://testbaruwa.com/api/v1/domainaliases/#{domainid}/#{aliasid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_domainalias(domainid, aliasid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domainaliases/#{domainid}/#{aliasid}")
    end

    it 'should delete a domain alias' do
        domainid = 10
        aliasid = 1
        stub_request(:delete, "https://testbaruwa.com/api/v1/domainaliases/#{domainid}/#{aliasid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_domainalias(domainid, aliasid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domainaliases/#{domainid}/#{aliasid}")
    end
end
