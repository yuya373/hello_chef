%w(git mercurial gettext libncurses5-dev libacl1-dev libgpm-dev libperl-dev python-dev python3-dev ruby-dev lua5.2 liblua5.2-dev luajit libluajit-5.1-dev exuberant-ctags clang).each do |package|
  package package
end

bash "clone vim" do
  not_if 'which vim | grep /usr/local/'
  cwd '/tmp'
  code <<-EOH
  ln -sf /usr/include/lua5.1/lua.h /usr/include/lua.h
  ln -sf /usr/bin/luajit-2.0.0-beta9 /usr/bin/luajit
  hg clone https://vim.googlecode.com/hg/vim vim
  cd /tmp/vim
  make distclean
  ./configure --with-features=huge --enable-gui=gnome2 \
  --enable-multibyte --prefix=/usr/local \
  --enable-perlinterp --enable-pythoninterp \
  --enable-python3interp --enable-rubyinterp \
  --with-lua-prefix=/usr \
  --enable-luainterp --with-luajit \
  --enable-fail-if-missing \
  make
  make install
  EOH
end

git "#{node.home_dir}" do
  user node.user
  repository 'https://github.com/yuya373/dotfiles.git'
  destination "#{node.home_dir}/dotfiles"
end

%W(#{node.home_dir}/.vim #{node.home_dir}/.vim/bundle).each do |dir|
  directory dir do
    owner node.user
    group node.group
    mode '0775'
    recursive true
    action :create
  end
end


git "#{node.home_dir}/.vim/bundle" do
  user node.user
  repository 'https://github.com/Shougo/neobundle.vim.git'
  destination "#{node.home_dir}/.vim/bundle/neobundle.vim"
end

bash 'install dotfiles' do
  user node.user
  cwd "#{node.home_dir}/dotfiles"
  code <<-EOH
  ln -sf #{node.home_dir}/dotfiles/.vimrc #{node.home_dir}/.vimrc
  EOH
end
