#################################################
# This script is an entrypoint of Agent Image   #
# it will be called from init.ps1, which is     #
# a part of DependencyImage                     #
#                                               #
# THIS FILE WILL BE DOWNLOADED FROM GITHUB      #
#                                               #
#################################################

param(
    [string]$agent_serverurl,
    [string]$agent_name,
    [string]$agent_pool,
    [string]$agent_token
)

$currentPath = (Get-Location).Path

$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "c:\agent\config.cmd"
$pinfo.Arguments = "--unattended", "--url $agent_serverurl", "--agent $agent_name", "--pool $agent_pool", "--auth PAT", "--token $agent_token", "--runasservice"
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

while ($true) { Start-Sleep 100000 } 