require 'spec_helper'

describe 'Test Domains' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    dom = {:name=>"example.net",
            :site_url=>"http://baruwa.example.net",
            :status=>"y",
            :smtp_callout=>"",
            :ldap_callout=>"",
            :virus_checks=>"y",
            :virus_checks_at_smtp=>"y",
            :spam_checks=>"y",
            :spam_actions=>"3",
            :highspam_actions=>"3",
            :virus_actions=>"3",
            :low_score=>"0.0",
            :high_score=>"0.0",
            :message_size=>"0",
            :delivery_mode=>"1",
            :language=>"en",
            :timezone=>"Africa/Johannesburg",
            :report_every=>"3",
            :organizations=>"1"}

    it 'should get domains' do
        stub_request(:get, "https://testbaruwa.com/api/v1/domains").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_domains()
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains")
    end

    it 'should get a domain' do
        domainid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/domains/#{domainid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_domain(domainid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/#{domainid}")
    end

    it 'should create a domain' do
        stub_request(:post, "https://testbaruwa.com/api/v1/domains").
        with(:body => @baruwapi.get_params(dom),
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_domain(dom)
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains")
    end

    it 'should update a domain' do
        domainid = 10
        stub_request(:put, "https://testbaruwa.com/api/v1/domains/#{domainid}").
        with(:body => @baruwapi.get_params(dom),
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_domain(domainid, dom)
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/#{domainid}")
    end

    it 'should delete a domain' do
        domainid = 10
        stub_request(:delete, "https://testbaruwa.com/api/v1/domains/#{domainid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_domain(domainid)
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/domains/#{domainid}")
    end

end
