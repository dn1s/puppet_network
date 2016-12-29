# Wrapper to create route resources from hiera
class puppet_network::routes (
  $routes=undef,
  $interfaces=[],
) {
  if $interfaces {
    file { '/etc/sysconfig/network-scripts':
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => "0755",
    }
    each($interfaces) |$interface| {
      file { "/etc/sysconfig/network-scripts/route-$interface":
        ensure => file,
        owner  => root,
        group  => root,
        mode   => "0644",
      }
    }
    if $routes {
      create_resources('puppet_network::create_route', $routes)
    }
  }
}