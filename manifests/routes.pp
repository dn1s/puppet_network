# Wrapper to create route resources from hiera
class puppet_network::routes (
  $routes=undef,
) {
  if $routes {
    file { '/etc/sysconfig/network-scripts':
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => "0755",
    }
    file { "/etc/sysconfig/network-scripts/route-$routes":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => "0644",
    }
    create_resources('puppet_network::create_route', $routes)
  }
}