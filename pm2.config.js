module.exports = {
  /**
   * Application configuration section
   * http://pm2.keymetrics.io/docs/usage/application-declaration/
   */
  apps: [// First application
    {
      name: 'jonluca',
      "script": "npm",
      "args": "start",
      env: {
        NODE_ENV: 'production'
      }
    }

  ]
};