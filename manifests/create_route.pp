# Example call:
#  puppet_network::create_route { 'eth0_10.12.0.0_16':
#    gateway   => '172.17.10.1',
#    interface => 'eth0',
#    netmask   => '16',
#    network   => '10.12.0.0',
#  }
define puppet_network::create_route (
  $gateway,
  $interface,
  $network = 'default',
  $netmask = undef,
) {
  if $netmask {
    file_line { "route-$interface-$network":
      path    => "/etc/sysconfig/network-scripts/route-$interface",
      content => "$network/$netmask via $gateway dev $interface",
    }
  }
  else {
    file { "/etc/sysconfig/network-scripts/route-$interface":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => "0644",
      content => "$network via $gateway dev $interface",
    }
  }
}