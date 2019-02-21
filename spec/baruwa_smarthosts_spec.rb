require 'spec_helper'

describe 'Test Domain Smarthosts' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get domain smarthosts' do
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/domains/smarthosts/#{domainid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_domain_smarthosts(domainid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/smarthosts/#{domainid}")
    end

    it 'should get domain smarthosts with pagination' do
        page = 1
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/domains/smarthosts/#{domainid}?page=#{page}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_domain_smarthosts(domainid, page)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/smarthosts/#{domainid}?page=#{page}")
    end

    it 'should get a domain smarthost' do
        domainid = 10
        smarthostid = 1
        stub_request(:get, "https://testbaruwa.com/api/v1/domains/smarthosts/#{domainid}/#{smarthostid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_domain_smarthost(domainid, smarthostid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/smarthosts/#{domainid}/#{smarthostid}")
    end

    it 'should create a domain smarthost' do
        domainid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/domains/smarthosts/#{domainid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_domain_smarthost(domainid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/smarthosts/#{domainid}")
    end

    it 'should update a domain smarthost' do
        domainid = 10
        smarthostid = 1
        stub_request(:put, "https://testbaruwa.com/api/v1/domains/smarthosts/#{domainid}/#{smarthostid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_domain_smarthost(domainid, smarthostid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/smarthosts/#{domainid}/#{smarthostid}")
    end

    it 'should delete a domain smarthost' do
        domainid = 10
        smarthostid = 1
        stub_request(:delete, "https://testbaruwa.com/api/v1/domains/smarthosts/#{domainid}/#{smarthostid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_domain_smarthost(domainid, smarthostid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/smarthosts/#{domainid}/#{smarthostid}")
    end
end
