package 'zsh'

git "#{node.home_dir}/dotfiles" do
  user node.user
  group node.group
  repository 'git@github.com:yuya373/dotfiles.git'
end

bash 'update submodules' do
  cwd "#{node.home_dir}/dotfiles"
  user node.user
  code 'git submodule update --init --recursive --force'
end

bash 'link zshrcs' do
  cwd node.home_dir
  user node.user
  code <<-EOH
  ln -sf ~/dotfiles/.zprezto ~/.zprezto
  ln -sf ~/dotfiles/.zprezto/runcoms/zlogin ~/.zlogin
  ln -sf ~/dotfiles/.zprezto/runcoms/zlogout ~/.zlogout
  ln -sf ~/dotfiles/.zpreztorc ~/.zpreztorc
  ln -sf ~/dotfiles/.zprofile ~/.zprofile
  ln -sf ~/dotfiles/.zshrc ~/.zshrc
  ln -sf ~/dotfiles/.zshenv ~/.zshenv
  EOH
end

user "#{node.user}" do
  shell '/bin/zsh'
end
