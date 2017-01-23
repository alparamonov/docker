#################################################
# Initialization script to start configuration  #
# of agent in mounted image                     #
#################################################
#                                               #
# The following environment variables are       #
# expected in the target container              #
#                                               #
#    agent_username                             #
#    agent_password                             #
#    agent_name                                 #
#    agent_serverurl                            #
#    agent_token                                #  
#                                               #
#################################################

param (
    [Parameter(Position=0)]
    [ValidateSet('TFS','Jenkins','SmthElse')]
    [string]$AgentType,

    [string]$agent_username,  
    [string]$agent_name, 
    [string]$agent_serverurl,
    [string]$agent_pool,
    [string]$agent_token     
)


New-Item -Type Directory -Path "C:\install"
New-Item -Type Directory -Path "C:\agent"
New-Item -Type Directory -Path "C:\cfg"

Get-Date -Format 'dd.MM.yyyy H:mm:ss'
Write-Output 'Get and install 7z'
Invoke-WebRequest -Uri "http://www.7-zip.org/a/7z1604-x64.msi" -OutFile "C:\install\7z1604-x64.msi"
Start-Process 'msiexec' -ArgumentList '/i C:\install\7z1604-x64.msi /qn' -NoNewWindow -Wait

function DownloadAndUnzipAgent ([string]$url) 
{
    Get-Date -Format 'dd.MM.yyyy H:mm:ss'
    Write-Output 'Get and extract VSTS agent'
    Invoke-WebRequest -Uri $url -OutFile "C:\install\agent.zip"
    Start-Process "$env:ProgramFiles\7-Zip\7z.exe" -ArgumentList 'x -y -oC:\agent C:\install\agent.zip' -NoNewWindow -Wait
    Get-ChildItem 'C:\agent'
    Get-Date -Format 'dd.MM.yyyy H:mm:ss'
    Write-Output 'Remove all installation files'
    Remove-Item C:/install -Recurse -Force
}

switch ($AgentType)
    { 
        'TFS' 
        {
            Get-Date -Format 'dd.MM.yyyy H:mm:ss'
            Write-Output 'Get Configure-Agent.ps1 script for ENTRYPOINT'
            Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/alparamonov/docker/master/ConfigureAgent.ps1' -OutFile "C:\cfg\Configure-Agent.ps1"

            DownloadAndUnzipAgent('https://github.com/Microsoft/vsts-agent/releases/download/v2.111.1/vsts-agent-win7-x64-2.111.1.zip')

            & "$env:SystemDrive\cfg\Configure-Agent.ps1" -agent_username $agent_username `
                -agent_token $agent_token `
                -agent_name $agent_name `
                -agent_serverurl $agent_serverurl `
                -agent_pool $agent_pool 
        } 

        'Jenkins' 
        {
            throw "No implementaion for Jenkins agent"
        } 
      
        default 
        {
            Write-Output "Set agent type. Exiting..."
            exit 1
        }
    }

Get-Date -Format 'dd.MM.yyyy H:mm:ss'
Write-Output 'Finishing script...' 