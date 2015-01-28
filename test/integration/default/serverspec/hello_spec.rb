require 'serverspec'

set :backend, :exec

describe 'Hello Chef' do
  describe file('/hello.txt') do
    it { should contain('World') }
  end
end
