bash "setup LAME" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
  tar xvzf lame-3.99.1.tar.gz
  cd lame-3.99.1
  ./configure --prefix=/usr
  make && make install
  EOH
end

