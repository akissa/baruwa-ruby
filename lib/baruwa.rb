# -*- encoding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4
# baruwa: Ruby bindings for the Baruwa REST API
# Copyright (C) 2015-2020 Andrew Colin Kissa <andrew@topdog.za.net>
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
require "cgi"
require "json"
require "openssl"
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
            :get_by_name => {:name => '/domains/byname/%s', :method => :get},
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
        :domainsmarthosts => {
            :list => {:name => '/domains/smarthosts/%s', :method => :get},
            :new => {:name => '/domains/smarthosts/%s', :method => :post},
            :get => {:name => '/domains/smarthosts/%s/%s', :method => :get},
            :update => {:name => '/domains/smarthosts/%s/%s', :method => :put},
            :delete => {:name => '/domains/smarthosts/%s/%s', :method => :delete}
        },
        :deliveryservers => {
            :list => {:name => '/deliveryservers/%s', :method => :get},
            :new => {:name => '/deliveryservers/%s', :method => :post},
            :get => {:name => '/deliveryservers/%s/%s', :method => :get},
            :update => {:name => '/deliveryservers/%s/%s', :method => :put},
            :delete => {:name => '/deliveryservers/%s/%s', :method => :delete}
        },
        :userdeliveryservers => {
            :list => {:name => '/userdeliveryservers/%s', :method => :get},
            :new => {:name => '/userdeliveryservers/%s', :method => :post},
            :get => {:name => '/userdeliveryservers/%s/%s', :method => :get},
            :update => {:name => '/userdeliveryservers/%s/%s', :method => :put},
            :delete => {:name => '/userdeliveryservers/%s/%s', :method => :delete}
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
        :fallbackservers => {
            :list => {:name => '/fallbackservers/list/%s', :method => :get},
            :new => {:name => '/fallbackservers/%s', :method => :post},
            :get => {:name => '/fallbackservers/%s', :method => :get},
            :update => {:name => '/fallbackservers/%s', :method => :put},
            :delete => {:name => '/fallbackservers/%s', :method => :delete}
        },
        :orgsmarthosts => {
            :list => {:name => '/organizations/smarthosts/%s', :method => :get},
            :new => {:name => '/organizations/smarthosts/%s', :method => :post},
            :get => {:name => '/organizations/smarthosts/%s/%s', :method => :get},
            :update => {:name => '/organizations/smarthosts/%s/%s', :method => :put},
            :delete => {:name => '/organizations/smarthosts/%s/%s', :method => :delete}
        },
        :status => {:name => '/status', :method => :get}
    }
    def initialize (url, token, ssl_verify=false)
      @baruwa_url = "#{url}/api/v1"
      @baruwa_token = token
      @ssl_verify = ssl_verify
    end

    def get_users(page=nil)
        # get users
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:users][:list], [], false, params)
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

    def get_domains(page=nil)
        # get domains
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:domains][:list], [], false, params)
    end

    def get_domain(domainid)
        # get a domain
        call_api(ENDPOINTS[:domains][:get], [domainid])
    end

    def get_domain_by_name(domainname)
        # get a domain by name
        call_api(ENDPOINTS[:domains][:get_by_name], [domainname])
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

    def get_domainaliases(domainid, page=nil)
        # get domain aliases
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:domainaliases][:list], [domainid], false, params)
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

    def get_domain_smarthosts(domainid, page=nil)
        # get domain smarthosts
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:domainsmarthosts][:list], [domainid], false, params)
    end

    def get_domain_smarthost(domainid, smarthostid)
        # get domain smarthost
        call_api(ENDPOINTS[:domainsmarthosts][:get], [domainid, smarthostid])
    end

    def create_domain_smarthost(domainid, data)
        # create a domain smarthost
        call_api(ENDPOINTS[:domainsmarthosts][:new], [domainid], data)
    end

    def update_domain_smarthost(domainid, smarthostid, data)
        # update a domain smarthost
        call_api(ENDPOINTS[:domainsmarthosts][:update], [domainid, smarthostid], data)
    end

    def delete_domain_smarthost(domainid, smarthostid, data)
        # delete a domain smarthost
        call_api(ENDPOINTS[:domainsmarthosts][:delete], [domainid, smarthostid], data)
    end

    def get_deliveryservers(domainid, page=nil)
        # get delivery servers
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:deliveryservers][:list], [domainid], false, params)
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

    def get_user_deliveryservers(domainid, page=nil)
        # get delivery servers
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:userdeliveryservers][:list], [domainid], false, params)
    end

    def get_user_deliveryserver(domainid, serverid)
        # get a delivery server
        call_api(ENDPOINTS[:userdeliveryservers][:get], [domainid, serverid])
    end

    def create_user_deliveryserver(domainid, data)
        # create a delivery server
        call_api(ENDPOINTS[:userdeliveryservers][:new], [domainid], data)
    end

    def update_user_deliveryserver(domainid, serverid, data)
        # update a delivery server
        call_api(ENDPOINTS[:userdeliveryservers][:update], [domainid, serverid], data)
    end

    def delete_user_deliveryserver(domainid, serverid, data)
        # delete delivery servers
        call_api(ENDPOINTS[:userdeliveryservers][:delete], [domainid, serverid], data)
    end

    def get_authservers(domainid, page=nil)
        # get auth servers
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:authservers][:list], [domainid], false, params)
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

    def get_organizations(page=nil)
        # get organizations
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:organizations][:list], [], false, params)
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

    def get_fallbackservers(orgid, page=nil)
        # get fallback servers
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:fallbackservers][:list], [orgid], false, params)
    end

    def get_fallbackserver(serverid)
        # get fallback server
        call_api(ENDPOINTS[:fallbackservers][:get], [serverid])
    end

    def create_fallbackserver(orgid, data)
        # create a fallback server
        call_api(ENDPOINTS[:fallbackservers][:new], [orgid], data)
    end

    def update_fallbackserver(serverid, data)
        # update a fallback server
        call_api(ENDPOINTS[:fallbackservers][:update], [serverid], data)
    end

    def delete_fallbackserver(serverid, data)
        # delete a fallback server
        call_api(ENDPOINTS[:fallbackservers][:delete], [serverid], data)
    end

    def get_org_smarthosts(orgid, page=nil)
        # get organization smarthosts
        params = {}
        if page.is_a? Integer then
            params[:page] = page
        end
        call_api(ENDPOINTS[:orgsmarthosts][:list], [orgid], false, params)
    end

    def get_org_smarthost(orgid, smarthostid)
        # get organization smarthost
        call_api(ENDPOINTS[:orgsmarthosts][:get], [orgid, smarthostid])
    end

    def create_org_smarthost(orgid, data)
        # create a organization smarthost
        call_api(ENDPOINTS[:orgsmarthosts][:new], [orgid], data)
    end

    def update_org_smarthost(orgid, smarthostid, data)
        # update a organization smarthost
        call_api(ENDPOINTS[:orgsmarthosts][:update], [orgid, smarthostid], data)
    end

    def delete_org_smarthost(orgid, smarthostid, data)
        # delete a organization smarthost
        call_api(ENDPOINTS[:orgsmarthosts][:delete], [orgid, smarthostid], data)
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
        url_string = url_string + '?' + get_params(params) if params
        uri = URI.parse(url_string)
        return uri
    end

    def set_headers
        {
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
            if response.body.nil? || response.body.empty?
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
