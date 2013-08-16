#
# Cookbook Name:: zomeki
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute

node.set[:timezone][:use_symlink] = false
node.set[:tz] = 'Asia/Tokyo'
include_recipe 'timezone-ii'
include_recipe 'yum::epel'
#include_recipe 'networking_basic'

%w{vim tcpdump git 
    gcc-c++ libffi-devel libyaml-devel make openssl-devel zlib-devel 
    wget make gcc-c++ 
    libxslt libxslt-devel libxml2-devel libyaml-devel readline-devel 
    libjpeg-devel libpng-devel 
    librsvg2-devel ghostscript-devel 
    ImageMagick ImageMagick-devel 
    curl-devel nkf openldap-devel 
    shared-mime-info 
    httpd httpd-devel 
    mysql-server mysql-devel 
}.each do |pkg|
  package pkg do
    action :install
  end
end

# create group dm_user
 group 'zomeki' do
   group_name 'zomeki'
   gid 2002
   action :create
 end
 # create user dm_user
 user 'zomeki' do
   comment 'user for zomeki system'
   uid 2002
   group 'zomeki'
   home '/home/zomeki'
   shell '/bin/bash'
   password '$1$Iph9f5zR$wbnaq/wLlGPYAQ1ge/wMS/'
   supports :manage_home => true
   action :create
 end

service "httpd" do
      supports :status => true, :restart => true, :reload => true
      action [ :enable, :restart ]
end

service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [ :enable, :restart ]
end

service "iptables" do
      action [ :disable, :stop ]
end

directory "/var/share" do
  owner "vagrant"
  group "vagrant"
  mode "0777"
  action :create
end

directory "/var/share/zomeki" do
  owner "vagrant"
  group "vagrant"
  mode "0777"
  action :create
end

git "/var/share/zomeki" do
  repository "https://github.com/zomeki/zomeki.git"
  reference "master"
  action :sync
  user "zomeki"
  group "zomeki"
end

directory "/var/share/zomeki" do
  owner "zomeki"
  group "zomeki"
  mode "0755"
  action :create
end

template "/var/share/zomeki/config/virtual-hosts/zomeki.conf" do
  source "zomeki.conf.erb"
  owner "zomeki"
  group "zomeki"
  mode 00644
end

execute "create zomeki database" do
  command "mysql -u root -e 'create database zomeki_production charset=utf8'"

  not_if "mysql -u root -e 'show databases;' | grep zomeki_production"
end

#directory "/usr/local/src" do
#  action :delete
#  only_if "test -d /usr/local/src"
#end

#directory "/usr/local/src" do
#  owner "root"
#  group "root"
#  mode "0777"
#  action :create
#end

remote_file "/usr/local/src/ruby-1.9.3-p374.tar.gz" do
  source "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p374.tar.gz"
  not_if "test -f /usr/local/src/ruby-1.9.3-p374.tar.gz"
end

remote_file "/usr/local/src/darts-0.32.tar.gz" do
  source "http://chasen.org/~taku/software/darts/src/darts-0.32.tar.gz"
  not_if "test -f /usr/local/src/darts-0.32.tar.gz"
end

remote_file "/usr/local/src/chasen-2.4.4.tar.gz" do
  source "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fchasen-legacy%2F32224%2Fchasen-2.4.4.tar.gz"
  not_if "test -f /usr/local/src/chasen-2.4.4.tar.gz"
end

remote_file "/usr/local/src/ipadic-2.7.0.tar.gz" do
  source "http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fipadic%2F24435%2Fipadic-2.7.0.tar.gz"
  not_if "test -f /usr/local/src/ipadic-2.7.0.tar.gz"
end

remote_file "/usr/local/src/lame-3.99.1.tar.gz" do
  source "http://jaist.dl.sourceforge.net/project/lame/lame/3.99/lame-3.99.1.tar.gz"
  not_if "test -f /usr/local/src/lame-3.99.1.tar.gz"
end

link "/etc/logrotate.d/zomeki" do
  to "/var/share/zomeki/script/zomeki"
end


template "/etc/my.cnf" do
  source "my.cnf.erb"
  owner "root"
  group "root"
  mode 00644
end

service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [ :enable, :restart ]
end

execute "setup mysql" do
  command "/usr/bin/mysql_install_db --user=mysql"
end

execute "make mysql user zomeki" do
  #command "/usr/bin/mysql -u root -ppass -e \"GRANT ALL ON zomeki_production.* TO zomeki@localhost IDENTIFIED BY 'pass'\""
  command "/usr/bin/mysql -u root -e \"GRANT ALL ON zomeki_production.* TO zomeki@localhost IDENTIFIED BY 'zomekipass'\""
end

%w{ruby}.each do |pkg|
  package pkg do
    action :remove
  end
end


