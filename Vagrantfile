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
        :server_root_password => 'root',
        :server_debian_password => 'root',
        :server_repl_password => 'root'
      },
      rbenv: {
        user_installs: [{
          user: "vagrant",
          rubies: ["1.9.3-p374"],
          global: "1.9.3-p374",
          gems: {
            "1.9.3-p374" => [
              {name: "bundler"}
            ]
          }
        }]
       }
     }

    chef.run_list = [
        "recipe[zomeki::default]",
        "ruby_build",
        "rbenv::user",
#        "recipe[zomeki::ruby]",
        "recipe[zomeki::gem]",
        "recipe[zomeki::passenger]",
        "recipe[zomeki::zomeki]"
    ]
  end
end
