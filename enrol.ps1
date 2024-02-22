$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.12.1-windows-x86_64.zip -OutFile elastic-agent-8.12.1-windows-x86_64.zip
Expand-Archive .\elastic-agent-8.12.1-windows-x86_64.zip -DestinationPath .
cd elastic-agent-8.12.1-windows-x86_64
.\elastic-agent.exe install --url=https://7a816ee180f54b31b165948c49b65122.fleet.us-central1.gcp.cloud.es.io:443 --enrollment-token=MGk5VnpvMEJDa3NIUUZadWFtZEg6aTdrd0JENkFRbWFZQ1ZvVld6RzJnQQ==