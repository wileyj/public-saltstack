#redis.disk

# class redis::lvm {
#     notify {" Installing Redis LVM Disk ": } ->
#     physical_volume {
#         '${redis_lvm_physical_volumes}':
#             ensure => present,
#     } ->
#     volume_group {
#         'rdbvg':
#             ensure           => present,
#             physical_volumes => $redis_lvm_physical_volumes;
#     } ->
#     logical_volume {
#         'redis':
#             ensure           => present,
#             volume_group     => $redis_lvm_volume_group,
#             size             => $redis_lvm_size;
#     } ->
#     filesystem {
#         '/dev/rdbvg/redis':
#             ensure           => present,
#             fs_type          => $redis_lvm_fstype,
#             options          => $redis_lvm_options;
#     } ->
#     mount {
#         '/var/lib/redis':
#             ensure => present,
#             device => '/dev/rdbvg/redis',
#             options => $redis_lvm_options;
#     }
# }
