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

#############################################################################################
# WORKAROUND FOR ERROR:                                                                     #
# Error: ENOENT: no such file or directory, lstat 'c:\ContainerMappedDirectories'           #
# 		- Issue for volumes: https://github.com/docker/docker/issues/27537                  #
#		- Issue node.js used in build tasks: https://github.com/nodejs/node/issues/8897     #
#############################################################################################

$agentTargetPath = 'c:\agent_copy'
$agentVolumePath = 'c:\agent'
mkdir $agentTargetPath
Copy-Item "$agentVolumePath\*" -Destination $agentTargetPath -Recurse

#############################################################################################

$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "$agentTargetPath\config.cmd"
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