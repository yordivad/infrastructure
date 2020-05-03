Vagrant.configure("2") do |config|

  config.vm.define "k8s-master" do |master|
      master.vm.box = "bento/ubuntu-16.04"
      master.vm.network "private_network", ip: "100.0.0.10"
      master.vm.hostname = "k8s-master"
      master.vm.provision "ansible" do |ansible|
          ansible.playbook = "playbook/master.yml"
          ansible.extra_vars = {
              node_ip: "100.0.0.10"
          }
      end
      master.vm.provider "virtualbox" do |v|
          v.memory = 1024
          v.cpus = 2
      end
  end


   (1..2).each do |i|
         config.vm.define "node-#{i}" do |node|
            node.vm.box = "bento/ubuntu-16.04"
            node.vm.network "private_network", ip: "100.0.0.#{i + 10}"
            node.vm.hostname = "node-#{i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "playbook/node.yml"
                ansible.extra_vars = {
                    node_ip: "100.0.0.#{i + 10}",
                }
            end

            node.vm.provider "virtualbox" do |v|
                      v.memory = 1024
                      v.cpus = 1
            end
         end
      end
end
