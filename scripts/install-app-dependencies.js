const { execSync } = require('child_process')

console.log('[install-app-dependencies] Starting back elixir dependencies install')
execSync('cd ./back && mix deps.get', { stdio: [process.stdin, process.stdout, process.stderr] })

console.log('[install-app-dependencies] Starting front js dependencies install')
execSync('cd ./front && npm install', { stdio: [process.stdin, process.stdout, process.stderr] })

console.log('[install-app-dependencies] All project dependencies installed')
