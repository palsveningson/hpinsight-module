# hpinsight module.

This module if used to setup HP Insight packages and settings.
The module also requires razorsedge-snmp module, which can be found here:
https://github.com/razorsedge/puppet-snmp
This is to make sure net-snmp is installed and configured correctly. For more info, please refeer to the readme of the module.

IMPORTANT!
For this module to work as it is supposed to, you need to specify the libcmaX64.so in the dlmod-variable for the snmp-module.
This is done by adding the following in your hiera:
snmp::dlmod: [ '/usr/lib64/libcmaX64.so' ]

To solve this a smoother way is on the "todo"-list of the next version.

===

# Compatibility

This module has been tested to work on the following systems with Puppet v3 (with and without the future parser) and Puppet v4 with Ruby versions 1.8.7, 1.9.3, 2.0.0 and 2.1.0.

  * EL5
  * EL6
  * EL7
  * Suse 10
  * Suse 11
  * Ubuntu 12.04
  * Ubuntu 14.04

===

# Parameters

ensure
------
String value controlling if the software is installed or removed. Valid values are 'present' and 'absent'.

- *Default*: present


pkgname
------
String value controlling name of the hp-health packages.

- *Default*: hp-health


hpsnmp_pkgname
------
String to set name of the hp snmp agent package

- *Default*: hp-snmp-agents


hp_snmp_agents
------
String to set name of the hp snmp agent service

- *Default*: hp-snmp-agents


hp_health
------
String to set name of the hp health service

- *Default*: hp-health


hpacucli
------
String to set name of Raid Management tools (Below V7 of OS)

- *Default*: hpacucli


hpssacli
------
String to set name of the Raid Management Tools (Above V7 of OS)

- *Default*: hpssacli


snmp_manage
------
String value controlling if hp snmp agent and net-snmp should be installed. Valid values are 'true' and 'false'

- *Default*: true
