# -*- encoding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4
# baruwa: Ruby bindings for the Baruwa REST API
# Copyright (C) 2015 Andrew Colin Kissa <andrew@topdog.za.net>
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
require "cgi"
require "json"
require "net/http"

require "baruwa/version"

class BaruwaAPIError < StandardError;end

class BaruwaAPI
    ENDPOINTS = {
        :users => {
            :list => {:name => '/users', :method => :get},
            :new => {:name => '/users', :method => :post},
            :get => {:name => '/users/%s', :method => :get},
            :update => {:name => '/users', :method => :put},
            :delete => {:name => '/users/%s', :method => :delete},
            :password => {:name => '/users/chpw/%s', :method => :post}
        },
        :aliases => {
            :get => {:name => '/aliasaddresses/%s', :method => :get},
            :new => {:name => '/aliasaddresses/%s', :method => :post},
            :update => {:name => '/aliasaddresses/%s', :method => :put},
            :delete => {:name => '/aliasaddresses/%s', :method => :delete}
        },
        :domains => {
            :list => {:name => '/domains', :method => :get},
            :new => {:name => '/domains', :method => :post},
            :get => {:name => '/domains/%s', :method => :get},
            :update => {:name => '/domains/%s', :method => :put},
            :delete => {:name => '/domains/%s', :method => :delete}
        },
        :domainaliases => {
            :list => {:name => '/domainaliases/%s', :method => :get},
            :new => {:name => '/domainaliases/%s', :method => :post},
            :get => {:name => '/domainaliases/%s/%s', :method => :get},
            :update => {:name => '/domainaliases/%s/%s', :method => :put},
            :delete => {:name => '/domainaliases/%s/%s', :method => :delete}
        },
        :deliveryservers => {
            :list => {:name => '/deliveryservers/%s', :method => :get},
            :new => {:name => '/deliveryservers/%s', :method => :post},
            :get => {:name => '/deliveryservers/%s/%s', :method => :get},
            :update => {:name => '/deliveryservers/%s/%s', :method => :put},
            :delete => {:name => '/deliveryservers/%s/%s', :method => :delete}
        },
        :authservers => {
            :list => {:name => '/authservers/%s', :method => :get},
            :new => {:name => '/authservers/%s', :method => :post},
            :get => {:name => '/authservers/%s/%s', :method => :get},
            :update => {:name => '/authservers/%s/%s', :method => :put},
            :delete => {:name => '/authservers/%s/%s', :method => :delete}
        },
        :ldapsettings => {
            :new => {:name => '/ldapsettings/%s/%s', :method => :post},
            :get => {:name => '/ldapsettings/%s/%s/%s', :method => :get},
            :update => {:name => '/ldapsettings/%s/%s/%s', :method => :put},
            :delete => {:name => '/ldapsettings/%s/%s/%s', :method => :delete}
        },
        :radiussettings => {
            :new => {:name => '/radiussettings/%s/%s', :method => :post},
            :get => {:name => '/radiussettings/%s/%s/%s', :method => :get},
            :update => {:name => '/radiussettings/%s/%s/%s', :method => :put},
            :delete => {:name => '/radiussettings/%s/%s/%s', :method => :delete}
        },
        :organizations => {
            :list => {:name => '/organizations', :method => :get},
            :new => {:name => '/organizations', :method => :post},
            :get => {:name => '/organizations/%s', :method => :get},
            :update => {:name => '/organizations/%s', :method => :put},
            :delete => {:name => '/organizations/%s', :method => :delete}
        },
        :relays => {
            :new => {:name => '/relays/%s', :method => :post},
            :get => {:name => '/relays/%s', :method => :get},
            :update => {:name => '/relays/%s', :method => :put},
            :delete => {:name => '/relays/%s', :method => :delete}
        },
        :status => {:name => '/status', :method => :get}
    }
    def initialize (url, token, ssl_verify=false)
      @baruwa_url = "#{url}/api/v1"
      @baruwa_token = token
      @ssl_verify = ssl_verify
    end

    def get_users
        # get users
        call_api(ENDPOINTS[:users][:list])
    end

    def get_user(userid)
        # get a user
        call_api(ENDPOINTS[:users][:get], [userid])
    end

    def create_user(data)
        # create a user
        call_api(ENDPOINTS[:users][:new], [], data)
    end

    def update_user(data)
        # update a user
        call_api(ENDPOINTS[:users][:update], [], data)
    end

    def delete_user(userid)
        # delete a user
        call_api(ENDPOINTS[:users][:delete], [userid])
    end

    def set_user_passwd(userid, data)
        # set a user password
        call_api(ENDPOINTS[:users][:password], [userid], data)
    end

    def get_aliases(addressid)
        # get aliases
        call_api(ENDPOINTS[:aliases][:get], [addressid])
    end

    def create_alias(userid, data)
        # create an alias address
        call_api(ENDPOINTS[:aliases][:new], [userid], data)
    end

    def update_alias(addressid, data)
        # update an alias address
        call_api(ENDPOINTS[:aliases][:update], [addressid], data)
    end

    def delete_alias(addressid, data)
        # delete an alias address
        call_api(ENDPOINTS[:aliases][:delete], [addressid], data)
    end

    def get_domains
        # get domains
        call_api(ENDPOINTS[:domains][:list])
    end

    def get_domain(domainid)
        # get a domain
        call_api(ENDPOINTS[:domains][:get], [domainid])
    end

    def create_domain(data)
        # create a domain
        call_api(ENDPOINTS[:domains][:new], [], data)
    end

    def update_domain(domainid, data)
        # update a domain
        call_api(ENDPOINTS[:domains][:update], [domainid], data)
    end

    def delete_domain(domainid)
        # delete a domain
        call_api(ENDPOINTS[:domains][:delete], [domainid])
    end

    def get_domainaliases(domainid)
        # get domain aliases
        call_api(ENDPOINTS[:domainaliases][:list], [domainid])
    end

    def get_domainalias(domainid, aliasid)
        # get domain alias
        call_api(ENDPOINTS[:domainaliases][:get], [domainid, aliasid])
    end

    def create_domainalias(domainid, data)
        # create a domain alias
        call_api(ENDPOINTS[:domainaliases][:new], [domainid], data)
    end

    def update_domainalias(domainid, aliasid, data)
        # update a domain alias
        call_api(ENDPOINTS[:domainaliases][:update], [domainid, aliasid], data)
    end

    def delete_domainalias(domainid, aliasid, data)
        # delete a domain alias
        call_api(ENDPOINTS[:domainaliases][:delete], [domainid, aliasid], data)
    end

    def get_deliveryservers(domainid)
        # get delivery servers
        call_api(ENDPOINTS[:deliveryservers][:list], [domainid])
    end

    def get_deliveryserver(domainid, serverid)
        # get a delivery server
        call_api(ENDPOINTS[:deliveryservers][:get], [domainid, serverid])
    end

    def create_deliveryserver(domainid, data)
        # create a delivery server
        call_api(ENDPOINTS[:deliveryservers][:new], [domainid], data)
    end

    def update_deliveryserver(domainid, serverid, data)
        # update a delivery server
        call_api(ENDPOINTS[:deliveryservers][:update], [domainid, serverid], data)
    end

    def delete_deliveryserver(domainid, serverid, data)
        # delete delivery servers
        call_api(ENDPOINTS[:deliveryservers][:delete], [domainid, serverid], data)
    end

    def get_authservers(domainid)
        # get auth servers
        call_api(ENDPOINTS[:authservers][:list], [domainid])
    end

    def get_authserver(domainid, serverid)
        # get auth server
        call_api(ENDPOINTS[:authservers][:get], [domainid, serverid])
    end

    def create_authserver(domainid, data)
        # create auth server
        call_api(ENDPOINTS[:authservers][:new], [domainid], data)
    end

    def update_authserver(domainid, serverid, data)
        # update an auth server
        call_api(ENDPOINTS[:authservers][:update], [domainid, serverid], data)
    end

    def delete_authserver(domainid, serverid, data)
        # delete an auth server
        call_api(ENDPOINTS[:authservers][:delete], [domainid, serverid], data)
    end

    def get_ldapsettings(domainid, serverid, settingsid)
        # get ldap settings
        call_api(ENDPOINTS[:ldapsettings][:get], [domainid, serverid, settingsid])
    end

    def create_ldapsettings(domainid, serverid, data)
        # create ldap settings
        call_api(ENDPOINTS[:ldapsettings][:new], [domainid, serverid], data)
    end

    def update_ldapsettings(domainid, serverid, settingsid, data)
        # update ldap settings
        call_api(ENDPOINTS[:ldapsettings][:update], [domainid, serverid, settingsid], data)
    end

    def delete_ldapsettings(domainid, serverid, settingsid, data)
        # delete ldap settings
        call_api(ENDPOINTS[:ldapsettings][:delete], [domainid, serverid, settingsid], data)
    end

    def get_radiussettings(domainid, serverid, settingsid)
        # get radius settings
        call_api(ENDPOINTS[:radiussettings][:get], [domainid, serverid, settingsid])
    end

    def create_radiussettings(domainid, serverid, data)
        # create radius settings
        call_api(ENDPOINTS[:radiussettings][:new], [domainid, serverid], data)
    end

    def update_radiussettings(domainid, serverid, settingsid, data)
        # update radius settings
        call_api(ENDPOINTS[:radiussettings][:update], [domainid, serverid, settingsid], data)
    end

    def delete_radiussettings(domainid, serverid, settingsid, data)
        # delete radius settings
        call_api(ENDPOINTS[:radiussettings][:delete], [domainid, serverid, settingsid], data)
    end

    def get_organizations
        # get organizations
        call_api(ENDPOINTS[:organizations][:list])
    end

    def get_organization(orgid)
        # get organization
        call_api(ENDPOINTS[:organizations][:get], [orgid])
    end

    def create_organization(data)
        # create an organization
        call_api(ENDPOINTS[:organizations][:new], [], data)
    end

    def update_organization(orgid, data)
        # update an organization
        call_api(ENDPOINTS[:organizations][:update], [orgid], data)
    end

    def delete_organization(orgid)
        # delete an organization
        call_api(ENDPOINTS[:organizations][:delete], [orgid])
    end

    def get_relay(relayid)
        # get a relay setting
        call_api(ENDPOINTS[:relays][:get], [relayid])
    end

    def create_relay(orgid, data)
        # create a relay setting
        call_api(ENDPOINTS[:relays][:new], [orgid], data)
    end

    def update_relay(relayid, data)
        # update relay settings
        call_api(ENDPOINTS[:relays][:update], [relayid], data)
    end

    def delete_relay(relayid, data)
        # delete relay settings
        call_api(ENDPOINTS[:relays][:delete], [relayid], data)
    end

    def get_status
        # get status
        call_api(ENDPOINTS[:status])
    end

    def get_params(params)
        # convert params has to string
        if params then
            params.collect {|k,v| "#{k}=#{CGI::escape(v.to_s)}"}.join('&')
        else
            params
        end
    end

    def parse_url(endpoint, opts, params=false)
        if opts.length > 0 then
            endpoint_string = endpoint[:name] % opts
        else
            endpoint_string = endpoint[:name]
        end
        url_string = @baruwa_url + endpoint_string
        url_string << params if params
        uri = URI.parse(url_string)
        return uri
    end

    def set_headers
        {
            'Content-Type' =>'application/json',
            'User-Agent' => 'BaruwaAPI-Ruby',
            'Authorization' => "Bearer #{@baruwa_token}"
        }
    end

    def get_request(endpoint, url)
        case endpoint[:method]
        when :post
            Net::HTTP::Post.new(url.request_uri, set_headers)
        when :get
            Net::HTTP::Get.new(url.request_uri, set_headers)
        when :put
            Net::HTTP::Put.new(url.request_uri, set_headers)
        when :delete
            Net::HTTP::Delete.new(url.request_uri, set_headers)
        else
            throw "Unknown call method #{endpoint[:method]}"
        end
    end

    def parse_response(response)
        if response.code.to_i == 200 || response.code.to_i == 201
            if response.body.nil? || response.body.blank?
                {:code => response.code.to_i, :message => "Completed successfully"}
            else
                JSON.parse(response.body)
            end
        else
            raise StandardError.new("#{response.code} #{response.body}")
        end
    end

    def call_api(endpoint, opts=[], data=false, params=false)
        url = parse_url(endpoint, opts, params)
        call = get_request(endpoint, url)
        call.body = get_params(data)
        request = Net::HTTP.new(url.host, url.port)
        usessl = @baruwa_url.match('https')
        request.use_ssl = usessl
        if usessl
            if @ssl_verify == false
                request.verify_mode = OpenSSL::SSL::VERIFY_NONE
            end
        end
        response = request.start {|http| http.request(call)}
        parse_response(response)
    end
end
