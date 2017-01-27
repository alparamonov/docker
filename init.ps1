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
    [string]$agent_username,  
    [string]$agent_name, 
    [string]$agent_serverurl,
    [string]$agent_pool,
    [string]$agent_token     
)

if ($agent_token -eq $null)
{
    & "$env:SystemDrive\cfg\Configure-Agent.ps1" -agent_username $agent_username `
        -agent_token $agent_token `
        -agent_name $agent_name `
        -agent_serverurl $agent_serverurl `
        -agent_pool $agent_pool 
}

if ($agent_token -ne $null)
{
    & "$env:SystemDrive\cfg\Configure-Agent.ps1" -agent_token $agent_token `
        -agent_name $agent_name `
        -agent_serverurl $agent_serverurl `
        -agent_pool $agent_pool
}