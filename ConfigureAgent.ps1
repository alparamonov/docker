param(
    [string]$serverUrl,
    [string]$dockerAgentContainer,
    [string]$agentPool,
    [string]$personalAccessToken
)

$currentPath = (Get-Location).Path

$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "c:\agent\config.cmd"
$pinfo.Arguments = "--unattended", "--url $serverUrl", "--agent $dockerAgentContainer", "--pool $agentPool", "--auth PAT", "--token $personalAccessToken", "--runasservice"
$pinfo.CreateNoWindow = $true
$pinfo.UseShellExecute = $false
$pinfo.CreateNoWindow = $true
$pinfo.RedirectStandardOutput = $true
$pinfo.RedirectStandardError = $true

$process = New-Object System.Diagnostics.Process
$process.StartInfo = $pinfo
$process.Start() | Out-Null
$process.WaitForExit()
$process.StandardOutput.ReadToEnd()
$process.StandardError.ReadToEnd()

while ($true) { sleep 100 } 