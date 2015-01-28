#
# Cookbook Name:: hello-chef
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'gdb'

file 'hello.txt' do
  content "Hello, World\n"
end
