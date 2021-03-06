template "/var/share/zomeki/config/core.yml" do
  source "core.yml.erb"
  owner "zomeki"
  group "zomeki"
  mode 00644
end

execute "create symblink zomeki.conf for Apache" do
  command "ln -s /var/share/zomeki/config/virtual-hosts/zomeki.conf /etc/httpd/conf.d/"
end

execute "create symblink zomeki.conf for Apache" do
  command "cp /var/share/zomeki/config/virtual-hosts/sites.conf.sample /var/share/zomeki/config/virtual-hosts/sites.conf"
end

bash "setup database for zomeki" do
  user "root"
  cwd "/var/share/zomeki/"
  code <<-EOH
  su - zomeki
  cd /var/share/zomeki/
  bundle exec rake db:setup RAILS_ENV=production
  EOH
end

service "httpd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end

