{% set intf_info = salt['junos.rpc']('get-interface-information', '', 'json', terse=True) %}
{% for interface in intf_info['rpc_reply']['interface-information'][0]['physical-interface'] %}
{% if interface['admin-status'][0]['data'] == 'down' %}
Enable interface {{ interface['name'][0]['data'] }}:
  junos.install_config:
   - name: salt://enable_interface.set
   - template_vars:
       interface_name: {{ interface['name'][0]['data'] }}
{% endif %}
{% endfor %}
