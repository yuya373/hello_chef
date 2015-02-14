%w(git build-essential libssl-dev libffi-dev).each do |package|
  package package
end

git "#{node.home_dir}/.rbenv" do
  user node.user
  group node.user
  repository "https://github.com/sstephenson/rbenv.git"
end

bash 'add rbenv path' do
  not_if "cat #{node.home_dir}/.bash_profile | grep '\$HOME/.rbenv/bin:'"
  code <<-EOH
  echo 'export PATH=\$HOME/.rbenv/bin:\$PATH' >> #{node.home_dir}/.bash_profile
  EOH
end

bash 'add rbenv init' do
  not_if "cat #{node.home_dir}/.bash_profile | grep 'rbenv init -'"
  code <<-EOH
  echo 'eval "$(rbenv init -)"' >> #{node.home_dir}/.bash_profile
  EOH
end

file "#{node.home_dir}/.bash_profile" do
  owner node.user
  group node.group
  mode 0775
end

%W(#{node.home_dir}/.rbenv #{node.home_dir}/.rbenv/plugins #{node.home_dir}/.rbenv/plugins/ruby-build).each do |dir|
  directory dir do
    owner node.user
    group node.group
    mode 0775
  end
end

git "#{node.home_dir}/.rbenv/plugins/ruby-build" do
  user node.user
  repository 'https://github.com/sstephenson/ruby-build.git'
end

bash 'install ruby' do
  not_if "#{node.home_dir}/.rbenv/bin/rbenv global | grep #{node.ruby.version}"
  code <<-EOH
  #{node.home_dir}/.rbenv/bin/rbenv install #{node.ruby.version}
  #{node.home_dir}/.rbenv/bin/rbenv global #{node.ruby.version}
  #{node.home_dir}/.rbenv/bin/rbenv rehash
  EOH
end

gem_package 'bundler' do
  action :install
end

bash 'chown rbenv' do
  code "chown -R #{node.user}:#{node.group} #{node.home_dir}/.rbenv"
end
