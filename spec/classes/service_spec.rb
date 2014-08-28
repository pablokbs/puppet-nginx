require 'spec_helper'
describe 'nginx::service::init' do

  let :facts do {
    :osfamily        => 'Debian',
    :operatingsystem => 'Debian',
  } end

  let :params do {
      :configtest_enable => false,
      :service_restart => '/etc/init.d/nginx configtest && /etc/init.d/nginx restart',
      :service_ensure => 'running',
  } end   

  context "using default parameters" do

    it { is_expected.to contain_service('nginx').with(
      :ensure     => 'running',
      :enable     => true,
      :hasstatus  => true,
      :hasrestart => true
    )}

    it { is_expected.to contain_service('nginx').without_restart }

  end

  describe "when configtest_enable => true" do
    let(:params) {{ :configtest_enable => true,  :service_restart => '/etc/init.d/nginx configtest && /etc/init.d/nginx restart'}}
    it { is_expected.to contain_service('nginx').with_restart('/etc/init.d/nginx configtest && /etc/init.d/nginx restart') }

    context "when service_restart => 'a restart command'" do
      let(:params) {{ :configtest_enable => true, :service_restart => 'a restart command' }}
      it { is_expected.to contain_service('nginx').with_restart('a restart command') }
    end
  end

end
