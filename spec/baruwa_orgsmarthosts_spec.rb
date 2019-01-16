require 'spec_helper'

describe 'Test Organization Smarthosts' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get organization smarthosts' do
        orgid = 10
        stub_request(:get, "https://testbaruwa.com/api/v1/organizations/smarthosts/#{orgid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_org_smarthosts(orgid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/organizations/smarthosts/#{orgid}")
    end

    it 'should get a organization smarthost' do
        orgid = 10
        smarthostid = 1
        stub_request(:get, "https://testbaruwa.com/api/v1/organizations/smarthosts/#{orgid}/#{smarthostid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_org_smarthost(orgid, smarthostid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/organizations/smarthosts/#{orgid}/#{smarthostid}")
    end

    it 'should create a organization smarthost' do
        orgid = 10
        stub_request(:post, "https://testbaruwa.com/api/v1/organizations/smarthosts/#{orgid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_org_smarthost(orgid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/organizations/smarthosts/#{orgid}")
    end

    it 'should update a organization smarthost' do
        orgid = 10
        smarthostid = 1
        stub_request(:put, "https://testbaruwa.com/api/v1/organizations/smarthosts/#{orgid}/#{smarthostid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_org_smarthost(orgid, smarthostid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/organizations/smarthosts/#{orgid}/#{smarthostid}")
    end

    it 'should delete a organization smarthost' do
        orgid = 10
        smarthostid = 1
        stub_request(:delete, "https://testbaruwa.com/api/v1/organizations/smarthosts/#{orgid}/#{smarthostid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_org_smarthost(orgid, smarthostid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/organizations/smarthosts/#{orgid}/#{smarthostid}")
    end
end
