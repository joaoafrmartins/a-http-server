module.exports =
  "port": 3000
  "kill": [
    "SIGTERM",
    "SIGINT",
    "SIGUSR2",
    "uncaughtException"
  ]
  "plugins":
    "a-http-server-plugin-shutdown": true
    "a-http-server-plugin-console": true
    "a-http-server-plugin-cors": true,
    "a-http-server-plugin-session": true
  "components": {}
