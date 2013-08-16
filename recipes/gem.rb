#bash "gem install bundler" do
#    user "root"
#    cwd "/var/share/zomeki/"
#    code <<-EOH
#    gem install bundler
#    bundle install --without test development
#    EOH
#end

#gem_package "bundler" do
#    action :install
#end


