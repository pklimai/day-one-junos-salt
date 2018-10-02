import salt.runner
from jnpr.jsnapy import SnapAdmin


def audit_config(*args, **kvargs):
    CONF_DATA = """
tests:
  - test_telnet.yml

mail: /etc/jsnapy/send_mail.yml

hosts:
"""

    vMX_1_DATA = """
  - device: 10.254.0.41
    username: lab
    passwd: lab123
"""

    vMX_2_DATA = """
  - device: 10.254.0.42
    username: lab
    passwd: lab123
"""

    if "device" in kvargs:
        if kvargs["device"] == "vMX-1":
            CONF_DATA += vMX_1_DATA
        if kvargs["device"] == "vMX-2":
            CONF_DATA += vMX_2_DATA
    else:  # possibly called by salt-run
        CONF_DATA += (vMX_1_DATA + vMX_2_DATA)

    snapadmin = SnapAdmin()
    result = snapadmin.snapcheck(CONF_DATA, "pre")
