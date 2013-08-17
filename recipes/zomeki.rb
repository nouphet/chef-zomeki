template "/var/share/zomeki/config/core.yml" do
  source "core.yml.erb"
  owner "zomeki"
  group "zomeki"
  mode 00644
end

execute "create symblink zomeki.conf for Apache" do
  command "ln -sf /var/share/zomeki/config/virtual-hosts/zomeki.conf /etc/httpd/conf.d/"
end

execute "create sites.conf for ZOMEKI" do
  command "cp /var/share/zomeki/config/virtual-hosts/sites.conf.sample /var/share/zomeki/config/virtual-hosts/sites.conf"
end

file "/var/share/zomeki/config/virtual-hosts/sites.conf" do
  owner "zomeki"
  group "zomeki"
  mode  "0755"
  action :create
end

#bash "setup database for zomeki" do
#  user "root"
#  cwd "/var/share/zomeki/"
#  code <<-EOH
#  su - zomeki
#  cd /var/share/zomeki/
#  bundle exec rake db:setup RAILS_ENV=production
#  EOH
#end

rbenv_script "migrate_rails_database" do
  rbenv_version "1.9.3-p374"
  user  "root"
  group "root"
  cwd   "/var/share/zomeki/"
  code  %{rake RAILS_ENV=production db:setup} 
end

service "httpd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end

