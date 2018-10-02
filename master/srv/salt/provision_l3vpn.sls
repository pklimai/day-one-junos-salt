Install the L3 VPN config:
  junos.install_config:
   - name: salt:///l3vpn.conf
   - replace: True
   - timeout: 100
   - diffs_file: /home/lab/diff-{{ grains.id }}.log
