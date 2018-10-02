# Uncomment depending on Chapter number:

# For Chapter 7:

Run task based on event:
  local.state.apply:
    - tgt: {{ data['hostname'] }}
    - arg:
      - post_to_slack


# For Chapter 8:

#Run task based on event:
#  local.state.apply:
#    - tgt: {{ data['hostname'] }}
#    - arg:
#      - check_interfaces


# For Chapter 11:

#Execute JSNAPy tests:
#  runner.run_jsnapy.audit_config:
#    - args:
#        device: {{ data['hostname'] }}

