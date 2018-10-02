{% set ospf_neighbors = salt['junos.rpc']('get-ospf-neighbor-information', '', 'json') %}

{% set full_neighbors_count = {'count': 0} %}
{% set expected_neighbors_count = 2 %}

{% for neighbor in ospf_neighbors['rpc_reply']['ospf-neighbor-information'][0]['ospf-neighbor'] %}
  {% if neighbor['ospf-neighbor-state'][0]['data'] == 'Full' %}
     {% if full_neighbors_count.update({'count': full_neighbors_count.count + 1}) %}
     {% endif %}
  {% endif %}
{% endfor %}

Print results of OSPF neighbor status test:
  module.run:
    - name: test.echo
      text:

{% if full_neighbors_count.count == expected_neighbors_count %}
        - OSPF neighbor test passed with {{ full_neighbors_count.count }} full neighbors
{% else %}
        - OSPF neighbor test failed with {{ full_neighbors_count.count }} full neighbors
{% endif %}
