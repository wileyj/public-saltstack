# virtual_type.EC2.common.statsd
statsd:
  config:
    # port: 8125
    # mgmt_port: 8126
    debug: false
    statsd_title: statsd
    healthStatus: up
    dumpMessages: false
    flushInterval: 1000
    percentThreshold:
      - 5
      - 90
      - 95
      - 99
    flush_counts: true
    graphite:
      legacyNamespace: false
      globalPrefix: 'statsd-{{ grains["id"] }}'
      prefixCounter: counters
      prefixGauge: gauges
      prefixSet: sets
