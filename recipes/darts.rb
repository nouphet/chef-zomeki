bash "setup Darts" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
  tar xvzf darts-0.32.tar.gz
  cd darts-0.32
  ./configure --prefix=/usr
  make && make install
  EOH
end

