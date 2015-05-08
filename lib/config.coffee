module.exports =
  'port': 3000
  'kill': [
    'SIGTERM',
    'SIGINT',
    'SIGUSR2',
    'uncaughtException'
  ]
  'components': {}
  'plugins':
    'a-http-server-plugin-error': true
    'a-http-server-plugin-shutdown': true
    'a-http-server-plugin-console': true
    'a-http-server-plugin-cors': true
    'a-http-server-plugin-session': true
  'middleware':
    'json':
      'strict': true
      'limit': '100kb'
    'urlencoded':
      'extended': true
      'limit': '100kb'
    'cookies':
      'secret': 'secret'
      'options':
        'secure': false
        'maxAge': 3600000
