# ふつうのLinuxプログラミングのためのレポジトリ

git "#{node.home_dir}/linux_programming" do
  user node.user
  repository 'git@github.com:yuya373/linux_programming.git'
end

package 'gdb'
