bash "setup IPAdic" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
  tar xvzf ipadic-2.7.0.tar.gz
  cd ipadic-2.7.0
  ./configure --prefix=/usr
  EOH
end

template "/usr/local/src/ipadic-2.7.0/to_utf8.sh" do
  source "to_utf8.sh.erb"
  owner "root"
  group "root"
  mode 00744
end

bash "setup IPAdic2" do
  user "root"
  cwd "/usr/local/src/ipadic-2.7.0"
  code <<-EOH
  ./to_utf8.sh
  ldconfig
  `chasen-config --mkchadic`/makemat -i w
  `chasen-config --mkchadic`/makeda -i w chadic *.dic
  make install
  EOH
end

