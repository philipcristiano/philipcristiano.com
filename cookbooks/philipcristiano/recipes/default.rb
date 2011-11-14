#
# Cookbook Name:: philipcristiano
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/nginx/sites-available/philipcristiano" do
    source "nginx.conf.erb"
    owner "www-data"
    group "www-data"
end

directory "/var/log/nginx/philipcristiano" do
    action :create
    owner "www-data"
end

directory "/var/www/philipcristiano" do
    action :create
    owner "www-data"
end

nginx_site "philipcristiano" do
    enable true
end
