{
  "Stop": false,
  "Region": "global",
  "Namespace": "default",
  "ID": "akostestmanual-1000",
  "ParentID": "",
  "Name": "akostestmanual-1000",
  "Type": "service",
  "Priority": 50,
  "AllAtOnce": false,
  "Datacenters": [
    "acme"
  ],
  "NodePool": "default",
  "Constraints": [
    {
      "LTarget": "${meta.node_type}",
      "RTarget": "aio",
      "Operand": "regexp"
    }
  ],
  "Affinities": null,
  "Spreads": null,
  "TaskGroups": [
    {
      "Name": "akostestmanual-group1-187h",
      "Count": 1,
      "Update": {
        "Stagger": 30000000000,
        "MaxParallel": 1,
        "HealthCheck": "checks",
        "MinHealthyTime": 5000000000,
        "HealthyDeadline": 120000000000,
        "ProgressDeadline": 7800000000000,
        "AutoRevert": false,
        "AutoPromote": false,
        "Canary": 0
      },
      "Migrate": {
        "MaxParallel": 1,
        "HealthCheck": "checks",
        "MinHealthyTime": 10000000000,
        "HealthyDeadline": 300000000000
      },
      "Constraints": [
        {
          "LTarget": "${attr.consul.version}",
          "RTarget": ">= 1.7.0",
          "Operand": "semver"
        }
      ],
      "Scaling": null,
      "RestartPolicy": {
        "Attempts": 2,
        "Interval": 1800000000000,
        "Delay": 15000000000,
        "Mode": "fail"
      },
      "Tasks": [
        {
          "Name": "akostestmanual-task1-4e9e",
          "Driver": "lxc",
          "User": "",
          "Config": {
            "uid_map": 12255232,
            "external_volumes": [],
            "template": "/usr/share/lxc/templates/lxc-radar",
            "verbosity": "verbose",
            "volumes": [
              "local/resolv.conf:etc/resolv.conf:file:root:root:0644",
              "local/ad9436e97551f9f80746b8fec572444c71fde428e28ef31666d1b579f3fe2f9b:etc/redis/redis.conf:file:root:root:0644",
              "local/894c44699c0d828b12ce595b9e89639da514fb99e8476d79f490e737950f3eba:etc/vector/vector.env:file:root:root:0644"
            ],
            "log_level": "error",
            "template_args": [
              "https://repository.rcs.internal/artifacts/images/lxc/buster/",
              "radar-redis",
              "v5.0.14"
            ],
            "ports": [],
            "release": "prod",
            "network_ipv4_gateway": "10.11.0.1"
          },
          "Env": null,
          "Services": [
            {
              "Name": "akostestmanual-task1-healthcheck-4e9e",
              "TaskName": "akostestmanual-task1-4e9e",
              "PortLabel": "",
              "AddressMode": "auto",
              "Address": "",
              "EnableTagOverride": false,
              "Tags": null,
              "CanaryTags": null,
              "Checks": [
                {
                  "Name": "redis_healthcheck",
                  "Type": "tcp",
                  "Command": "",
                  "Args": null,
                  "Path": "",
                  "Protocol": "",
                  "PortLabel": "6379",
                  "Expose": false,
                  "AddressMode": "driver",
                  "Interval": 10000000000,
                  "Timeout": 10000000000,
                  "InitialStatus": "",
                  "TLSServerName": "",
                  "TLSSkipVerify": false,
                  "Method": "",
                  "Header": null,
                  "CheckRestart": null,
                  "GRPCService": "",
                  "GRPCUseTLS": false,
                  "TaskName": "4e9e",
                  "SuccessBeforePassing": 0,
                  "FailuresBeforeCritical": 0,
                  "Body": "",
                  "OnUpdate": "require_healthy"
                }
              ],
              "Connect": null,
              "Meta": null,
              "CanaryMeta": null,
              "TaggedAddresses": null,
              "Namespace": "default",
              "OnUpdate": "require_healthy",
              "Provider": "consul"
            },
            {
              "Name": "akostestmanual-service",
              "TaskName": "akostestmanual-task1-4e9e",
              "PortLabel": "6379",
              "AddressMode": "driver",
              "Address": "",
              "EnableTagOverride": false,
              "Tags": null,
              "CanaryTags": null,
              "Checks": null,
              "Connect": null,
              "Meta": null,
              "CanaryMeta": null,
              "TaggedAddresses": null,
              "Namespace": "default",
              "OnUpdate": "require_healthy",
              "Provider": "consul"
            },
            {
              "Name": "akostestmanual-metrics",
              "TaskName": "akostestmanual-task1-4e9e",
              "PortLabel": "10000",
              "AddressMode": "driver",
              "Address": "",
              "EnableTagOverride": false,
              "Tags": [
                "prometheus",
                "exporter",
                "metrics"
              ],
              "CanaryTags": null,
              "Checks": null,
              "Connect": null,
              "Meta": null,
              "CanaryMeta": null,
              "TaggedAddresses": null,
              "Namespace": "default",
              "OnUpdate": "require_healthy",
              "Provider": "consul"
            },
            {
              "Name": "akostestmanual",
              "TaskName": "akostestmanual-task1-4e9e",
              "PortLabel": "",
              "AddressMode": "driver",
              "Address": "",
              "EnableTagOverride": false,
              "Tags": null,
              "CanaryTags": null,
              "Checks": null,
              "Connect": null,
              "Meta": null,
              "CanaryMeta": null,
              "TaggedAddresses": null,
              "Namespace": "default",
              "OnUpdate": "require_healthy",
              "Provider": "consul"
            }
          ],
          "Vault": null,
          "Templates": [
            {
              "SourcePath": "",
              "DestPath": "local/resolv.conf",
              "EmbeddedTmpl": "nameserver 10.11.0.4",
              "ChangeMode": "restart",
              "ChangeSignal": "",
              "ChangeScript": null,
              "Splay": 5000000000,
              "Perms": "0644",
              "Uid": null,
              "Gid": null,
              "LeftDelim": "{{",
              "RightDelim": "}}",
              "Envvars": false,
              "VaultGrace": 0,
              "Wait": null,
              "ErrMissingKey": false
            },
            {
              "SourcePath": "",
              "DestPath": "local/ad9436e97551f9f80746b8fec572444c71fde428e28ef31666d1b579f3fe2f9b",
              "EmbeddedTmpl": "# Redis configuration file example\n\n# Note on units: when memory size is needed, it is possible to specify\n# it in the usual form of 1k 5GB 4M and so forth:\n#\n# 1k => 1000 bytes\n# 1kb => 1024 bytes\n# 1m => 1000000 bytes\n# 1mb => 1024*1024 bytes\n# 1g => 1000000000 bytes\n# 1gb => 1024*1024*1024 bytes\n#\n# units are case insensitive so 1GB 1Gb 1gB are all the same.\n\n# By default Redis does not run as a daemon. Use 'yes' if you need it.\n# Note that Redis will write a pid file in /var/run/redis.pid when daemonized.\ndaemonize yes\n\n# When running daemonized, Redis writes a pid file in /var/run/redis.pid by\n# default. You can specify a custom pid file location here.\npidfile /var/run/redis/redis-server.pid\n\n# Accept connections on the specified port, default is 6379.\n# If port 0 is specified Redis will not listen on a TCP socket.\nport 6379\n\n# If you want you can bind a single interface, if the bind option is not\n# specified all the interfaces will listen for incoming connections.\n#\nbind 0.0.0.0\n\n# Specify the path for the unix socket that will be used to listen for\n# incoming connections. There is no default, so Redis will not listen\n# on a unix socket when not specified.\n#\n# unixsocket /tmp/redis.sock\n# unixsocketperm 755\n\n# Close the connection after a client is idle for N seconds (0 to disable)\ntimeout 0\n\n# TCP keepalive.\n#\n# If non-zero, use SO_KEEPALIVE to send TCP ACKs to clients in absence\n# of communication. This is useful for two reasons:\n#\n# 1) Detect dead peers.\n# 2) Take the connection alive from the point of view of network\n#    equipment in the middle.\n#\n# On Linux, the specified value (in seconds) is the period used to send ACKs.\n# Note that to close the connection the double of the time is needed.\n# On other kernels the period depends on the kernel configuration.\n#\n# A reasonable value for this option is 60 seconds.\ntcp-keepalive 0\n\n# Specify the server verbosity level.\n# This can be one of:\n# debug (a lot of information, useful for development/testing)\n# verbose (many rarely useful info, but not a mess like the debug level)\n# notice (moderately verbose, what you want in production probably)\n# warning (only very important / critical messages are logged)\nloglevel notice\n\n# Specify the log file name. Also 'stdout' can be used to force\n# Redis to log on the standard output. Note that if you use standard\n# output for logging but daemonize, logs will be sent to /dev/null\n\nlogfile /var/log/redis/redis-server.log\n\n# To enable logging to the system logger, just set 'syslog-enabled' to yes,\n# and optionally update the other syslog parameters to suit your needs.\n# syslog-enabled no\n\n# Specify the syslog identity.\n# syslog-ident redis\n\n# Specify the syslog facility. Must be USER or between LOCAL0-LOCAL7.\n# syslog-facility local0\n\n# Set the number of databases. The default database is DB 0, you can select\n# a different one on a per-connection basis using SELECT <dbid> where\n# dbid is a number between 0 and 'databases'-1\n\ndatabases 16\n\n################################ SNAPSHOTTING  #################################\n#\n# Save the DB on disk:\n#\n#   save <seconds> <changes>\n#\n#   Will save the DB if both the given number of seconds and the given\n#   number of write operations against the DB occurred.\n#\n#   In the example below the behaviour will be to save:\n#   after 900 sec (15 min) if at least 1 key changed\n#   after 300 sec (5 min) if at least 10 keys changed\n#   after 60 sec if at least 10000 keys changed\n#\n#   Note: you can disable saving at all commenting all the \"save\" lines.\n#\n#   It is also possible to remove all the previously configured save\n#   points by adding a save directive with a single empty string argument\n#   like in the following example:\n#\n#   save \"\"\n\nsave 900 1\nsave 300 10\nsave 60 10000\n\n# By default Redis will stop accepting writes if RDB snapshots are enabled\n# (at least one save point) and the latest background save failed.\n# This will make the user aware (in an hard way) that data is not persisting\n# on disk properly, otherwise chances are that no one will notice and some\n# distater will happen.\n#\n# If the background saving process will start working again Redis will\n# automatically allow writes again.\n#\n# However if you have setup your proper monitoring of the Redis server\n# and persistence, you may want to disable this feature so that Redis will\n# continue to work as usually even if there are problems with disk,\n# permissions, and so forth.\nstop-writes-on-bgsave-error yes\n\n# Compress string objects using LZF when dump .rdb databases?\n# For default that's set to 'yes' as it's almost always a win.\n# If you want to save some CPU in the saving child set it to 'no' but\n# the dataset will likely be bigger if you have compressible values or keys.\nrdbcompression yes\n\n# Since version 5 of RDB a CRC64 checksum is placed at the end of the file.\n# This makes the format more resistant to corruption but there is a performance\n# hit to pay (around 10%) when saving and loading RDB files, so you can disable it\n# for maximum performances.\n#\n# RDB files created with checksum disabled have a checksum of zero that will\n# tell the loading code to skip the check.\nrdbchecksum yes\n\n# The filename where to dump the DB\ndbfilename dump.rdb\n\n# The working directory.\n#\n# The DB will be written inside this directory, with the filename specified\n# above using the 'dbfilename' configuration directive.\n#\n# The Append Only File will also be created inside this directory.\n#\n# Note that you must specify a directory here, not a file name.\ndir /srv/data/redis_data/\n\n################################# REPLICATION #################################\n\n# Master-Slave replication. Use slaveof to make a Redis instance a copy of\n# another Redis server. Note that the configuration is local to the slave\n# so for example it is possible to configure the slave to save the DB with a\n# different interval, or to listen to another port, and so on.\n#\n# slaveof <masterip> <masterport>\n\n# If the master is password protected (using the \"requirepass\" configuration\n# directive below) it is possible to tell the slave to authenticate before\n# starting the replication synchronization process, otherwise the master will\n# refuse the slave request.\n#\n# masterauth <master-password>\n\n# When a slave loses its connection with the master, or when the replication\n# is still in progress, the slave can act in two different ways:\n#\n# 1) if slave-serve-stale-data is set to 'yes' (the default) the slave will\n#    still reply to client requests, possibly with out of date data, or the\n#    data set may just be empty if this is the first synchronization.\n#\n# 2) if slave-serve-stale-data is set to 'no' the slave will reply with\n#    an error \"SYNC with master in progress\" to all the kind of commands\n#    but to INFO and SLAVEOF.\n#\nslave-serve-stale-data yes\n\n# You can configure a slave instance to accept writes or not. Writing against\n# a slave instance may be useful to store some ephemeral data (because data\n# written on a slave will be easily deleted after resync with the master) but\n# may also cause problems if clients are writing to it because of a\n# misconfiguration.\n#\n# Since Redis 2.6 by default slaves are read-only.\n#\n# Note: read only slaves are not designed to be exposed to untrusted clients\n# on the internet. It's just a protection layer against misuse of the instance.\n# Still a read only slave exports by default all the administrative commands\n# such as CONFIG, DEBUG, and so forth. To a limited extend you can improve\n# security of read only slaves using 'rename-command' to shadow all the\n# administrative / dangerous commands.\nslave-read-only yes\n\n# Slaves send PINGs to server in a predefined interval. It's possible to change\n# this interval with the repl_ping_slave_period option. The default value is 10\n# seconds.\n#\n# repl-ping-slave-period 10\n\n# The following option sets a timeout for both Bulk transfer I/O timeout and\n# master data or ping response timeout. The default value is 60 seconds.\n#\n# It is important to make sure that this value is greater than the value\n# specified for repl-ping-slave-period otherwise a timeout will be detected\n# every time there is low traffic between the master and the slave.\n#\n# repl-timeout 60\n\n# Disable TCP_NODELAY on the slave socket after SYNC?\n#\n# If you select \"yes\" Redis will use a smaller number of TCP packets and\n# less bandwidth to send data to slaves. But this can add a delay for\n# the data to appear on the slave side, up to 40 milliseconds with\n# Linux kernels using a default configuration.\n#\n# If you select \"no\" the delay for data to appear on the slave side will\n# be reduced but more bandwidth will be used for replication.\n#\n# By default we optimize for low latency, but in very high traffic conditions\n# or when the master and slaves are many hops away, turning this to \"yes\" may\n# be a good idea.\nrepl-disable-tcp-nodelay no\n\n# The slave priority is an integer number published by Redis in the INFO output.\n# It is used by Redis Sentinel in order to select a slave to promote into a\n# master if the master is no longer working correctly.\n#\n# A slave with a low priority number is considered better for promotion, so\n# for instance if there are three slaves with priority 10, 100, 25 Sentinel will\n# pick the one wtih priority 10, that is the lowest.\n#\n# However a special priority of 0 marks the slave as not able to perform the\n# role of master, so a slave with priority of 0 will never be selected by\n# Redis Sentinel for promotion.\n#\n# By default the priority is 100.\nslave-priority 100\n\n################################## SECURITY ###################################\n\n# Require clients to issue AUTH <PASSWORD> before processing any other\n# commands.  This might be useful in environments in which you do not trust\n# others with access to the host running redis-server.\n#\n# This should stay commented out for backward compatibility and because most\n# people do not need auth (e.g. they run their own servers).\n#\n# Warning: since Redis is pretty fast an outside user can try up to\n# 150k passwords per second against a good box. This means that you should\n# use a very strong password otherwise it will be very easy to break.\n#\n# requirepass foobared\n\n# Command renaming.\n#\n# It is possible to change the name of dangerous commands in a shared\n# environment. For instance the CONFIG command may be renamed into something\n# hard to guess so that it will still be available for internal-use tools\n# but not available for general clients.\n#\n# Example:\n#\n# rename-command CONFIG b840fc02d524045429941cc15f59e41cb7be6c52\n#\n# It is also possible to completely kill a command by renaming it into\n# an empty string:\n#\n# rename-command CONFIG \"\"\n#\n# Please note that changing the name of commands that are logged into the\n# AOF file or transmitted to slaves may cause problems.\n\n################################### LIMITS ####################################\n\n# Set the max number of connected clients at the same time. By default\n# this limit is set to 10000 clients, however if the Redis server is not\n# able to configure the process file limit to allow for the specified limit\n# the max number of allowed clients is set to the current file limit\n# minus 32 (as Redis reserves a few file descriptors for internal uses).\n#\n# Once the limit is reached Redis will close all the new connections sending\n# an error 'max number of clients reached'.\n#\n# maxclients 10000\n\n# Don't use more memory than the specified amount of bytes.\n# When the memory limit is reached Redis will try to remove keys\n# accordingly to the eviction policy selected (see maxmemmory-policy).\n#\n# If Redis can't remove keys according to the policy, or if the policy is\n# set to 'noeviction', Redis will start to reply with errors to commands\n# that would use more memory, like SET, LPUSH, and so on, and will continue\n# to reply to read-only commands like GET.\n#\n# This option is usually useful when using Redis as an LRU cache, or to set\n# an hard memory limit for an instance (using the 'noeviction' policy).\n#\n# WARNING: If you have slaves attached to an instance with maxmemory on,\n# the size of the output buffers needed to feed the slaves are subtracted\n# from the used memory count, so that network problems / resyncs will\n# not trigger a loop where keys are evicted, and in turn the output\n# buffer of slaves is full with DELs of keys evicted triggering the deletion\n# of more keys, and so forth until the database is completely emptied.\n#\n# In short... if you have slaves attached it is suggested that you set a lower\n# limit for maxmemory so that there is some free RAM on the system for slave\n# output buffers (but this is not needed if the policy is 'noeviction').\n#\n# maxmemory <bytes>\n\n# MAXMEMORY POLICY: how Redis will select what to remove when maxmemory\n# is reached. You can select among five behaviors:\n#\n# volatile-lru -> remove the key with an expire set using an LRU algorithm\n# allkeys-lru -> remove any key accordingly to the LRU algorithm\n# volatile-random -> remove a random key with an expire set\n# allkeys-random -> remove a random key, any key\n# volatile-ttl -> remove the key with the nearest expire time (minor TTL)\n# noeviction -> don't expire at all, just return an error on write operations\n#\n# Note: with any of the above policies, Redis will return an error on write\n#       operations, when there are not suitable keys for eviction.\n#\n#       At the date of writing this commands are: set setnx setex append\n#       incr decr rpush lpush rpushx lpushx linsert lset rpoplpush sadd\n#       sinter sinterstore sunion sunionstore sdiff sdiffstore zadd zincrby\n#       zunionstore zinterstore hset hsetnx hmset hincrby incrby decrby\n#       getset mset msetnx exec sort\n#\n# The default is:\n#\n# maxmemory-policy volatile-lru\n\n# LRU and minimal TTL algorithms are not precise algorithms but approximated\n# algorithms (in order to save memory), so you can select as well the sample\n# size to check. For instance for default Redis will check three keys and\n# pick the one that was used less recently, you can change the sample size\n# using the following configuration directive.\n#\n# maxmemory-samples 3\n\n############################## APPEND ONLY MODE ###############################\n\n# By default Redis asynchronously dumps the dataset on disk. This mode is\n# good enough in many applications, but an issue with the Redis process or\n# a power outage may result into a few minutes of writes lost (depending on\n# the configured save points).\n#\n# The Append Only File is an alternative persistence mode that provides\n# much better durability. For instance using the default data fsync policy\n# (see later in the config file) Redis can lose just one second of writes in a\n# dramatic event like a server power outage, or a single write if something\n# wrong with the Redis process itself happens, but the operating system is\n# still running correctly.\n#\n# AOF and RDB persistence can be enabled at the same time without problems.\n# If the AOF is enabled on startup Redis will load the AOF, that is the file\n# with the better durability guarantees.\n#\n# Please check http://redis.io/topics/persistence for more information.\n\nappendonly no\n\n# The name of the append only file (default: \"appendonly.aof\")\n# appendfilename appendonly.aof\n\n# The fsync() call tells the Operating System to actually write data on disk\n# instead to wait for more data in the output buffer. Some OS will really flush\n# data on disk, some other OS will just try to do it ASAP.\n#\n# Redis supports three different modes:\n#\n# no: don't fsync, just let the OS flush the data when it wants. Faster.\n# always: fsync after every write to the append only log . Slow, Safest.\n# everysec: fsync only one time every second. Compromise.\n#\n# The default is \"everysec\", as that's usually the right compromise between\n# speed and data safety. It's up to you to understand if you can relax this to\n# \"no\" that will let the operating system flush the output buffer when\n# it wants, for better performances (but if you can live with the idea of\n# some data loss consider the default persistence mode that's snapshotting),\n# or on the contrary, use \"always\" that's very slow but a bit safer than\n# everysec.\n#\n# More details please check the following article:\n# http://antirez.com/post/redis-persistence-demystified.html\n#\n# If unsure, use \"everysec\".\n\n# appendfsync always\nappendfsync everysec\n# appendfsync no\n\n# When the AOF fsync policy is set to always or everysec, and a background\n# saving process (a background save or AOF log background rewriting) is\n# performing a lot of I/O against the disk, in some Linux configurations\n# Redis may block too long on the fsync() call. Note that there is no fix for\n# this currently, as even performing fsync in a different thread will block\n# our synchronous write(2) call.\n#\n# In order to mitigate this problem it's possible to use the following option\n# that will prevent fsync() from being called in the main process while a\n# BGSAVE or BGREWRITEAOF is in progress.\n#\n# This means that while another child is saving, the durability of Redis is\n# the same as \"appendfsync none\". In practical terms, this means that it is\n# possible to lose up to 30 seconds of log in the worst scenario (with the\n# default Linux settings).\n#\n# If you have latency problems turn this to \"yes\". Otherwise leave it as\n# \"no\" that is the safest pick from the point of view of durability.\nno-appendfsync-on-rewrite no\n\n# Automatic rewrite of the append only file.\n# Redis is able to automatically rewrite the log file implicitly calling\n# BGREWRITEAOF when the AOF log size grows by the specified percentage.\n#\n# This is how it works: Redis remembers the size of the AOF file after the\n# latest rewrite (if no rewrite has happened since the restart, the size of\n# the AOF at startup is used).\n#\n# This base size is compared to the current size. If the current size is\n# bigger than the specified percentage, the rewrite is triggered. Also\n# you need to specify a minimal size for the AOF file to be rewritten, this\n# is useful to avoid rewriting the AOF file even if the percentage increase\n# is reached but it is still pretty small.\n#\n# Specify a percentage of zero in order to disable the automatic AOF\n# rewrite feature.\n\nauto-aof-rewrite-percentage 100\nauto-aof-rewrite-min-size 64mb\n\n################################ LUA SCRIPTING  ###############################\n\n# Max execution time of a Lua script in milliseconds.\n#\n# If the maximum execution time is reached Redis will log that a script is\n# still in execution after the maximum allowed time and will start to\n# reply to queries with an error.\n#\n# When a long running script exceed the maximum execution time only the\n# SCRIPT KILL and SHUTDOWN NOSAVE commands are available. The first can be\n# used to stop a script that did not yet called write commands. The second\n# is the only way to shut down the server in the case a write commands was\n# already issue by the script but the user don't want to wait for the natural\n# termination of the script.\n#\n# Set it to 0 or a negative value for unlimited execution without warnings.\nlua-time-limit 5000\n\n################################## SLOW LOG ###################################\n\n# The Redis Slow Log is a system to log queries that exceeded a specified\n# execution time. The execution time does not include the I/O operations\n# like talking with the client, sending the reply and so forth,\n# but just the time needed to actually execute the command (this is the only\n# stage of command execution where the thread is blocked and can not serve\n# other requests in the meantime).\n#\n# You can configure the slow log with two parameters: one tells Redis\n# what is the execution time, in microseconds, to exceed in order for the\n# command to get logged, and the other parameter is the length of the\n# slow log. When a new command is logged the oldest one is removed from the\n# queue of logged commands.\n\n# The following time is expressed in microseconds, so 1000000 is equivalent\n# to one second. Note that a negative number disables the slow log, while\n# a value of zero forces the logging of every command.\nslowlog-log-slower-than 10000\n\n# There is no limit to this length. Just be aware that it will consume memory.\n# You can reclaim memory used by the slow log with SLOWLOG RESET.\nslowlog-max-len 128\n\n############################### ADVANCED CONFIG ###############################\n\n# Hashes are encoded using a memory efficient data structure when they have a\n# small number of entries, and the biggest entry does not exceed a given\n# threshold. These thresholds can be configured using the following directives.\nhash-max-ziplist-entries 512\nhash-max-ziplist-value 64\n\n# Similarly to hashes, small lists are also encoded in a special way in order\n# to save a lot of space. The special representation is only used when\n# you are under the following limits:\nlist-max-ziplist-entries 512\nlist-max-ziplist-value 64\n\n# Sets have a special encoding in just one case: when a set is composed\n# of just strings that happens to be integers in radix 10 in the range\n# of 64 bit signed integers.\n# The following configuration setting sets the limit in the size of the\n# set in order to use this special memory saving encoding.\nset-max-intset-entries 512\n\n# Similarly to hashes and lists, sorted sets are also specially encoded in\n# order to save a lot of space. This encoding is only used when the length and\n# elements of a sorted set are below the following limits:\nzset-max-ziplist-entries 128\nzset-max-ziplist-value 64\n\n# Active rehashing uses 1 millisecond every 100 milliseconds of CPU time in\n# order to help rehashing the main Redis hash table (the one mapping top-level\n# keys to values). The hash table implementation Redis uses (see dict.c)\n# performs a lazy rehashing: the more operation you run into an hash table\n# that is rehashing, the more rehashing \"steps\" are performed, so if the\n# server is idle the rehashing is never complete and some more memory is used\n# by the hash table.\n#\n# The default is to use this millisecond 10 times every second in order to\n# active rehashing the main dictionaries, freeing memory when possible.\n#\n# If unsure:\n# use \"activerehashing no\" if you have hard latency requirements and it is\n# not a good thing in your environment that Redis can reply form time to time\n# to queries with 2 milliseconds delay.\n#\n# use \"activerehashing yes\" if you don't have such hard requirements but\n# want to free memory asap when possible.\nactiverehashing yes\n\n# The client output buffer limits can be used to force disconnection of clients\n# that are not reading data from the server fast enough for some reason (a\n# common reason is that a Pub/Sub client can't consume messages as fast as the\n# publisher can produce them).\n#\n# The limit can be set differently for the three different classes of clients:\n#\n# normal -> normal clients\n# slave  -> slave clients and MONITOR clients\n# pubsub -> clients subcribed to at least one pubsub channel or pattern\n#\n# The syntax of every client-output-buffer-limit directive is the following:\n#\n# client-output-buffer-limit <class> <hard limit> <soft limit> <soft seconds>\n#\n# A client is immediately disconnected once the hard limit is reached, or if\n# the soft limit is reached and remains reached for the specified number of\n# seconds (continuously).\n# So for instance if the hard limit is 32 megabytes and the soft limit is\n# 16 megabytes / 10 seconds, the client will get disconnected immediately\n# if the size of the output buffers reach 32 megabytes, but will also get\n# disconnected if the client reaches 16 megabytes and continuously overcomes\n# the limit for 10 seconds.\n#\n# By default normal clients are not limited because they don't receive data\n# without asking (in a push way), but just after a request, so only\n# asynchronous clients may create a scenario where data is requested faster\n# than it can read.\n#\n# Instead there is a default limit for pubsub and slave clients, since\n# subscribers and slaves receive data in a push fashion.\n#\n# Both the hard or the soft limit can be disabled by setting them to zero.\nclient-output-buffer-limit normal 0 0 0\nclient-output-buffer-limit slave 256mb 64mb 60\nclient-output-buffer-limit pubsub 32mb 8mb 60\n\n# Redis calls an internal function to perform many background tasks, like\n# closing connections of clients in timeot, purging expired keys that are\n# never requested, and so forth.\n#\n# Not all tasks are perforemd with the same frequency, but Redis checks for\n# tasks to perform accordingly to the specified \"hz\" value.\n#\n# By default \"hz\" is set to 10. Raising the value will use more CPU when\n# Redis is idle, but at the same time will make Redis more responsive when\n# there are many keys expiring at the same time, and timeouts may be\n# handled with more precision.\n#\n# The range is between 1 and 500, however a value over 100 is usually not\n# a good idea. Most users should use the default of 10 and raise this up to\n# 100 only in environments where very low latency is required.\nhz 10\n\n# When a child rewrites the AOF file, if the following option is enabled\n# the file will be fsync-ed every 32 MB of data generated. This is useful\n# in order to commit the file to the disk more incrementally and avoid\n# big latency spikes.\naof-rewrite-incremental-fsync yes\n\n################################## INCLUDES ###################################\n\n# Include one or more other config files here.  This is useful if you\n# have a standard template that goes to all Redis server but also need\n# to customize a few per-server settings.  Include files can include\n# other files, so use this wisely.\n#\n# include /path/to/local.conf\n# include /path/to/other.conf\n",
              "ChangeMode": "restart",
              "ChangeSignal": "",
              "ChangeScript": null,
              "Splay": 5000000000,
              "Perms": "0644",
              "Uid": null,
              "Gid": null,
              "LeftDelim": "{{",
              "RightDelim": "}}",
              "Envvars": false,
              "VaultGrace": 0,
              "Wait": null,
              "ErrMissingKey": false
            },
            {
              "SourcePath": "",
              "DestPath": "local/894c44699c0d828b12ce595b9e89639da514fb99e8476d79f490e737950f3eba",
              "EmbeddedTmpl": "VECTOR_CUSTOMER=\"acme\"\nVECTOR_HOST=\"4e9e\"\nVECTOR_CLICKHOUSE_HOST=\"http://sinkhole.service.consul:8123\"\nVECTOR_CLICKHOUSE_USER=\"vector\"\nVECTOR_CLICKHOUSE_PASSWORD=\"Xns0CbDFwswdtKQONMIqORZSE6ZvrE\"\nLOG=error",
              "ChangeMode": "restart",
              "ChangeSignal": "",
              "ChangeScript": null,
              "Splay": 5000000000,
              "Perms": "0644",
              "Uid": null,
              "Gid": null,
              "LeftDelim": "{{",
              "RightDelim": "}}",
              "Envvars": false,
              "VaultGrace": 0,
              "Wait": null,
              "ErrMissingKey": false
            }
          ],
          "Constraints": null,
          "Affinities": null,
          "Resources": {
            "CPU": 800,
            "Cores": 0,
            "MemoryMB": 1024,
            "MemoryMaxMB": 0,
            "DiskMB": 0,
            "IOPS": 0,
            "Networks": null,
            "Devices": null
          },
          "RestartPolicy": {
            "Attempts": 2,
            "Interval": 1800000000000,
            "Delay": 15000000000,
            "Mode": "fail"
          },
          "DispatchPayload": null,
          "Lifecycle": null,
          "Meta": {
            "task_id": "22"
          },
          "KillTimeout": 5000000000,
          "LogConfig": {
            "MaxFiles": 10,
            "MaxFileSizeMB": 10,
            "Disabled": false
          },
          "Artifacts": null,
          "Leader": false,
          "ShutdownDelay": 0,
          "VolumeMounts": null,
          "ScalingPolicies": null,
          "KillSignal": "",
          "Kind": "",
          "CSIPluginConfig": null,
          "Identity": null
        }
      ],
      "EphemeralDisk": {
        "Sticky": false,
        "SizeMB": 300,
        "Migrate": false
      },
      "Meta": null,
      "ReschedulePolicy": {
        "Attempts": 0,
        "Interval": 0,
        "Delay": 30000000000,
        "DelayFunction": "exponential",
        "MaxDelay": 3600000000000,
        "Unlimited": true
      },
      "Affinities": null,
      "Spreads": null,
      "Networks": null,
      "Consul": {
        "Namespace": ""
      },
      "Services": null,
      "Volumes": null,
      "ShutdownDelay": null,
      "StopAfterClientDisconnect": null,
      "MaxClientDisconnect": null
    }
  ],
  "Update": {
    "Stagger": 30000000000,
    "MaxParallel": 1,
    "HealthCheck": "",
    "MinHealthyTime": 0,
    "HealthyDeadline": 0,
    "ProgressDeadline": 0,
    "AutoRevert": false,
    "AutoPromote": false,
    "Canary": 0
  },
  "Multiregion": null,
  "Periodic": null,
  "ParameterizedJob": null,
  "Dispatched": false,
  "DispatchIdempotencyToken": "",
  "Payload": null,
  "Meta": null,
  "ConsulToken": "",
  "ConsulNamespace": "",
  "VaultToken": "",
  "VaultNamespace": "",
  "NomadTokenID": "",
  "Status": "running",
  "StatusDescription": "",
  "Stable": true,
  "Version": 4,
  "SubmitTime": 1701334487671987700,
  "CreateIndex": 1047059,
  "ModifyIndex": 1047106,
  "JobModifyIndex": 1047096
}