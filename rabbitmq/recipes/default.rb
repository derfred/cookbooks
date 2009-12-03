package "rabbitmq-server"

node[:rabbitmq][:virtual_hosts].each do |vhost|
  rabbitmq_vhost do
    vhost_name vhost
  end
end

node[:rabbitmq][:users].each do |user_hash|
  rabbitmq_user do
    user_name user_hash[:name]
    password user_hash[:password]
  end

  [user_hash[:permissions]].flatten.each do |perm_hash|
    rabbitmq_permission do
      user_name user_hash[:name]
      vhost(perm_hash[:vhost] || "/")
      configure_access(perm_hash[:configure] || ".*")
      write_access(perm_hash[:write] || ".*")
      read_access(perm_hash[:read] || ".*")
    end
  end
end
