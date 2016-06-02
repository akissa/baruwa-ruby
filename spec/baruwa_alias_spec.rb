require 'spec_helper'

describe 'Test Aliases' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    it 'should get aliases' do
        addressid = 2
        stub_request(:get, "https://testbaruwa.com/api/v1/aliasaddresses/#{addressid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_aliases(addressid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/aliasaddresses/#{addressid}")
    end

    it 'should create an alias' do
        addressid = 2
        stub_request(:post, "https://testbaruwa.com/api/v1/aliasaddresses/#{addressid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_alias(addressid, {})
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/aliasaddresses/#{addressid}")
    end

    it 'should update an alias' do
        addressid = 2
        stub_request(:put, "https://testbaruwa.com/api/v1/aliasaddresses/#{addressid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_alias(addressid, {})
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/aliasaddresses/#{addressid}")
    end

    it 'should delete an alias' do
        addressid = 2
        stub_request(:delete, "https://testbaruwa.com/api/v1/aliasaddresses/#{addressid}").
        with(:body => {},
            :headers => {'Accept'=>'*/*',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_alias(addressid, {})
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/aliasaddresses/#{addressid}")
    end
end
