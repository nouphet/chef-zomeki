
gem_package "rake" do
    version '0.9.2.2'
    action  :remove
end

gem_package "rake" do
    version '0.9.2'
    action  :install
end

gem_package "multi_json" do
    version '1.7.2'
end

#gem_package "bundler" do
#    cwd "/var/share/zomeki/"
#    action :install
#end

bash "gem install bundler" do
    user "root"
    cwd "/var/share/zomeki/"
    code <<-EOH
    cd /var/share/zomeki/
    gem install bundler
    bundle install --without test development
    EOH
end

gem_package "activesupport" do
    version '3.1.12'
end

