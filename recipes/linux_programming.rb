# ふつうのLinuxプログラミングのためのレポジトリ

directory "#{node.home_dir}/linux_programming" do
  user node.user
  group node.group
  mode 0755
end

git "#{node.home_dir}/linux_programming" do
  user node.user
  group node.group
  repository 'git@github.com:yuya373/linux_programming.git'
end

package 'gdb'
