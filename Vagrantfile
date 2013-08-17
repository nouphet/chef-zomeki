# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "osslife-st01"
  config.vm.box = "zomeki_centos_64"
  config.vm.network :private_network, ip: "33.33.33.33"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password   => 'root',
        :server_debian_password => 'root',
        :server_repl_password   => 'root'
      }
     }

    chef.run_list = [
        "recipe[zomeki::default]",
        "recipe[zomeki::rbenv]",
        "recipe[zomeki::install_ruby]",
        "recipe[zomeki::gem]",
        "recipe[zomeki::passenger]",
        "recipe[zomeki::zomeki]",
        "recipe[zomeki::lame]",
        "recipe[zomeki::darts]",
        "recipe[zomeki::chasen]",
        "recipe[zomeki::ipadic]"
    ]
  end
end

