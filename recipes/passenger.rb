bash "install passenger" do
  user "root"
  cwd "/var/share/zomeki/"
  code <<-EOH
  gem install passenger -v 3.0.19
  passenger-install-apache2-module -a
  EOH
end

template "/var/share/zomeki/config/samples/passenger.conf" do
  source "passenger.conf.erb"
  owner "zomeki"
  group "zomeki"
  mode 00644
end

execute "create symblink passenger.conf" do
  command "cp /var/share/zomeki/config/samples/passenger.conf /etc/httpd/conf.d/"
end

