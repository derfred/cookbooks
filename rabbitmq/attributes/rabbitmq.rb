rabbitmq Mash.new unless attribute?("rabbitmq")

rabbitmq[:virtual_hosts] = [] unless rabbitmq.has_key?(:virtual_hosts)
rabbitmq[:users] = [] unless rabbitmq.has_key?(:users)
