[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}; $webClient = New-Object System.Net.WebClient; $webClient.DownloadFile('https://master.devops:8140/packages/current/install.ps1', 'c:\Windows\temp\install.ps1'); c:\windows\temp\install.ps1