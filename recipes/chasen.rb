bash "setup Chasen" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
  tar xvzf chasen-2.4.4.tar.gz
  cd chasen-2.4.4
  ./configure --prefix=/usr
  make && make install
  EOH
end

