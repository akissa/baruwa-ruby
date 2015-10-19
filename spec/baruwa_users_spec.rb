require 'spec_helper'
require 'cgi'

describe 'Test Users' do
    before(:each) do
        WebMock.reset!
    end

    before do
        @baruwapi = BaruwaAPI.new('https://testbaruwa.com', '6e2347bc-278e-42f6-a84b-fa1766140cbd')
    end

    user = {:username=>"blossom",
            :firstname=>"Blossom",
            :lastname=>"Utonium",
            :password1=>"ng5qhhbiwozcANc3",
            :password2=>"ng5qhhbiwozcANc3",
            :email=>"blossom@example.com",
            :timezone=>"Africa/Johannesburg",
            :account_type=>"3",
            :domains=>"9",
            :active=>"y",
            :send_report=>"y",
            :spam_checks=>"y",
            :low_score=>"0.0",
            :high_score=>"0.0"}

    it 'should get users' do
        stub_request(:get, "https://testbaruwa.com/api/v1/users").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_users()
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/users")
    end

    it 'should get a user' do
        userid = 20
        stub_request(:get, "https://testbaruwa.com/api/v1/users/#{userid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.get_user(userid)
        expect(WebMock).to have_requested(:get, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/users/#{userid}")
    end

    it 'should create a user' do
        stub_request(:post, "https://testbaruwa.com/api/v1/users").
        with(:body => @baruwapi.get_params(user),
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.create_user(user)
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/users")
    end

    it 'should update a user' do
        stub_request(:put, "https://testbaruwa.com/api/v1/users").
        with(:body => @baruwapi.get_params(user),
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.update_user(user)
        expect(WebMock).to have_requested(:put, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/users")
    end

    it 'should delete a user' do
        userid = 20
        stub_request(:delete, "https://testbaruwa.com/api/v1/users/#{userid}").
        with(:body => false,
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.delete_user(userid)
        expect(WebMock).to have_requested(:delete, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/users/#{userid}")
    end

    it 'should set a user password' do
        userid = 20
        data = {:password1=>"Hp9hzcd1grdSqtrn",
                :password2=>"Hp9hzcd1grdSqtrn"}
        stub_request(:post, "https://testbaruwa.com/api/v1/users/chpw/#{userid}").
        with(:body => @baruwapi.get_params(data),
            :headers => {'Accept'=>'*/*',
                        'Content-Type'=>'application/json',
                        'User-Agent'=>'BaruwaAPI-Ruby',
                        'Authorization'=>'Bearer 6e2347bc-278e-42f6-a84b-fa1766140cbd'}).
        to_return(:status => 200, :body => "", :headers => {})
        @baruwapi.set_user_passwd(userid, data)
        expect(WebMock).to have_requested(:post, "#{@baruwapi.instance_variable_get(:@baruwa_url)}/users/chpw/#{userid}")
    end
end
