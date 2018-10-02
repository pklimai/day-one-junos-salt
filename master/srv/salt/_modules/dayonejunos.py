def hello(*args, **kwargs):
    ret = {}
    ret['pillar'] = __pillar__
    ret['grain'] = __grains__
    ret['rpc_result'] = __salt__['junos.rpc']('get-interface-information')
    return ret


# (1)  Perform the required imports
from lxml import etree


# (2)  Execution function definition
def check_traceoptions(*args, **kwargs):
    '''
    Execution function to check if non-deactivated traceoptions
    are enabled in Junos device configuration
    '''

    # (3)  Get reference to the Device instance
    conn = __proxy__['junos.conn']()

    # (4) Create an empty dictionary
    ret = {}

    # (5)  Fill in values corresponding to 'result' and 'out' keys
    ret['result'] = True
    ret['out'] = True

    # (6)  Try executing the <get-config> Junos RPC
    try:
        conf = conn.rpc.get_config()
    # (7)  In case of an error, stop
    except Exception as exception:
        ret['message'] = 'RPC execution failed due to "{0}"'.format(exception)
        ret['out'] = False
        ret['result'] = None
        return ret

    # (8)  Build XML Element Tree
    conf_tree = etree.ElementTree(conf)

    # (9)  Perform hierarchical search for <traceoptions> tag
    traceoptions_list = conf_tree.xpath(".//traceoptions")

    # (10)  The hierarchies list will store configuration stanzas
    # where non-deactivated traceoptions were found
    hierarchies = []

    # (11)  Iterate over the traceoptions_list
    for traceopt in traceoptions_list:
        # Only append configuration hierarchy to the list if
        # traceoptions are active (no 'inactive' attribute )
        # at this level
        if traceopt.xpath("./@inactive") != ["inactive"]:
            hierarchies.append(conf_tree.getpath(traceopt))

    # (12)  Update the result dictionary with found hierarchies
    ret['conf_stanzas'] = hierarchies

    # (13)  Set message in the result dictionary
    if len(hierarchies) != 0:
        ret['result'] = False
        ret['message'] = "Enabled traceoptions were detected!"
    else:
        ret['message'] = "No traceoptions for this device"

    # (14)  Return the result from execution function
    return ret
