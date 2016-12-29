# Example call:
#  puppet_network::create_route { 'eth0_10.12.0.0_16':
#    gateway   => '172.17.10.1',
#    interface => 'eth0',
#    network   => '10.12.0.0/16',
#  }
define puppet_network::create_route (
  $gateway,
  $interface,
  $network = 'default',
) {
  if $network == 'default' {
    file { "/etc/sysconfig/network-scripts/route-$interface":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => "0644",
      content => "$network via $gateway dev $interface",
    }
  }
  else {
    file_line { "route-$interface-$network":
      path    => "/etc/sysconfig/network-scripts/route-$interface",
      content => "$network via $gateway dev $interface",
    }
  }
}
