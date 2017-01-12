# == Class: hpinsight
#
# Manage HP Insight
#
class hpinsight(
  $snmp_manage             = true,
  $ensure                  = 'present',
  $hpacucli                = $hpinsight_test::params::hpacucli,
  $hpssacli                = $hpinsight_test::params::hpssacli,
  $hp_snmp_agents          = $hpinsight_test::params::hp_snmp_agents,
  $hp_health               = $hpinsight_test::params::hp_health,
) inherits hpinsight_test::params {

# Load default parameters according to OS

  case $::osfamily {
    'RedHat', 'Suse': {
      $hpi_packages    = $hpinsight_test::params::pkgname
      $hp_snmp_package = $hpinsight_test::params::hpsnmp_pkgname
        }
      
    'Debian': {
      $hpi_packages = $hpinsight_test::params::pkgname
    }

    default: {
      fail("supports osfamilies RedHat, Suse and Debian. Detected osfamily <${::osfamily}>.")
    }
 } 

# Validation of the snmp_manage input
  validate_bool($snmp_manage)
 

## We only start the installation if ensure is present, if it is not we will remove all packages (see below)
  if $ensure == 'present' { 
  
# Package Installation
# For Virtual - No HP packages
  if $::manufacturer == 'HP' and $::virtual == 'physical' {
      package {[$hpi_packages, $hp_snmp_package]:
      ensure  => 'present' }

      # HP Storage - raid management tools, need to check HW model also
      # hpssacli HP SSA is now standard, please check for requirement of hpacucli
      # http://h20564.www2.hpe.com/hpsc/swd/public/detail?swItemId=MTX_b6a6acb9762443b182280db805#tab1
      # Site specific requirement for hpacucli
    if $::operatingsystemmajrelease < 7 {
      package { [$hpacucli]:
      ensure => 'present',
     }
    } else {
      package { [$hpssacli]:
      ensure => 'present',
     }
    }
  }

    service { [$hp_health]:
      ensure  => running,
      status  => 'hpasmxld || pgrep hpasmlited',
      require => Package[$hpi_packages],
    }
  }

  


# SNMP  - Service configuration and hp-snmp config. Only if user wants to use the snmp-module to manage snmp.
# This will install hps snmp software aswell as net-snmp since it is a dependency.

  if $snmp_manage == true {
    contain ::snmp

    service { [$hp_snmp_agents]:
      ensure  => running,
      status  => 'pgrep cmahealthd',
      require => [ Package[$hpi_packages], Class[::snmp] ]    
    }
}
 elsif $ensure == 'absent' {
      package {[$hpi_packages, $hp_snmp_package, ]:
      ensure  => 'absent' }
    }

}
