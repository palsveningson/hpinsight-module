require 'spec_helper'

describe 'hpinsight' do
  platforms = {
    'RedHat' =>
      {
        :osfamily     => 'RedHat',
        :package_name => 'hp-health',
        :service_name => 'hp-health',
      },
    'Suse' =>
      {
        :osfamily     => 'Suse',
        :package_name => 'hp-health',
        :service_name => 'hp-health',
      },
    'Debian' =>
      {
        :osfamily     => 'Debian',
        :package_name => 'hp-health',
        :service_name => 'hp-health',
      },
  }

  describe 'with default values for parameters' do
    platforms.sort.each do |k,v|
      context "where osfamily is <#{v[:osfamily]}>" do
        let :facts do
          {
            :osfamily     => v[:osfamily],
            :architecture => 'x86_64',
            :manufacturer => 'HP',
            :virtual => 'physical',
          }
        end

        it {
          should contain_package("#{v[:package_name]}").with({
            'ensure' => 'present',
            'name'   => v[:package_name],
          })
        }

        it {
          should contain_service("#{v[:service_name]}").with({
            'ensure'    => 'running',
            'name'      => v[:service_name],
          })
        }

      end
    end
  end
end

