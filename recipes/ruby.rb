#bash "install ruby" do
#    user "root"
#    cwd "/usr/local/src/"
#    not_if "`ruby -v |awk '{print $2}'` == '1.9.3p374'"
#    code <<-EOH
#    tar xvzf ruby-1.9.3-p374.tar.gz
#    cd ruby-1.9.3-p374
#    ./configure
#    make && make install
#    EOH
#end

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby "Ruby 1.9.3" do
  ruby_version "1.9.3-p374"
  force true
end

rbenv_gem "bundler" do
  ruby_version "1.9.3-p374"
end


