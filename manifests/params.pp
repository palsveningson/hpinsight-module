#Class with default values for common variables
class hpinsight::params {
#Names for packages  
  $pkgname            = 'hp-health' #Default for Redhat, Suse and Debian
  $hpsnmp_pkgname     = 'hp-snmp-agents' #Default for Redhat and Suse. Not available in Debian
#Names for services - Default for all supported OS
  $hp_snmp_agents          = 'hp-snmp-agents'
  $hp_health               = 'hp-health'
# Below are HP Storage - raid management tool names, default for all OS
  $hpacucli                = 'hpacucli'
  $hpssacli                = 'hpssacli'
}
