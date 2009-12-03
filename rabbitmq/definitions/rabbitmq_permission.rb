define :rabbitmq_permission do
  execute "setting rabbitmq permissions for #{params[:user_name]} vhost #{params[:vhost]}" do
    command "rabbitmqctl set_permissions -p #{params[:vhost]} #{params[:user_name]} \"#{params[:configure_access]}\" \"#{params[:write_access]}\" \"#{params[:read_access]}\""
    not_if do
      perm_line = "#{params[:vhost]}	#{params[:configure_access]}	#{params[:write_access]}	#{params[:read_access]}"
      `rabbitmqctl -q list_user_permissions #{params[:user_name]}`.split("\n").include?(perm_line)
    end
  end
end
