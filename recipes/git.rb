package 'python-software-properties'

bash 'add repositry' do
  code 'sudo add-apt-repository ppa:git-core/ppa'
end

bash 'apt-get update' do
  code 'sudo apt-get update'
end

package 'git'

bash 'link gitconfig' do
  code 'ln -sf ~/dotfiles/.gitconfig ~/.gitconfig'
end

