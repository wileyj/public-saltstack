# base.limits
limits:
    users:
        '*':
          - limit_type: hard
            limit_item: nofile
            limit_value: 102400
          - limit_type: soft
            limit_item: nofile
            limit_value: 102400
          - limit_type: hard
            limit_item: core
            limit_value: 0
    groups:
        admins:
          - limit_type: hard
            limit_item: nofile
            limit_value: unlimited
          - limit_type: soft
            limit_item: nofile
            limit_value: unlimited
