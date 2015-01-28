#
# Cookbook Name:: hello-chef
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

file 'hello.txt' do
  content "Hello, World\n"
end
