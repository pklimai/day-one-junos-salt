#! py

def run():
    full_neighbors_count = 0
    expected_neighbors_count = 2
    ospf_neighbors = __salt__['junos.rpc']('get-ospf-neighbor-information', '', 'json')
    for neighbor in ospf_neighbors['rpc_reply']['ospf-neighbor-information'][0]['ospf-neighbor']:
        if neighbor['ospf-neighbor-state'][0]['data'] == 'Full':
            full_neighbors_count += 1
    if full_neighbors_count == expected_neighbors_count:
        txt_result = "OSPF neighbor test passed with %s full neighbors " % full_neighbors_count
    else:
        txt_result = "OSPF neighbor test failed with %s full neighbors " % full_neighbors_count
    res = {
        "Print results of OSPF neighbor status test" :  {
            "module.run": [ { "name": "test.echo", "text": [ txt_result ] } ]
        }
    }
    return res
