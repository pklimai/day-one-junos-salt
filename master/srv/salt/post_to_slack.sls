slack-message:
  slack.post_message:
    - channel: '#general'
    - from_name: pklimai
    - message: '{{ grains.id }}: This state was executed successfully.'
    - api_key: XXXXX-XXXXXX-XXXXXX-XXXXXX
