# !/bin/bash

# Specify target resource group and tag
subscription='7dcf7d82-02f5-4995-80d9-c84f88197343'
resource_group='webapps3-dev-rg'
tag='Action' 

# Set subscription
az account set --subscription ${subscription}

# Get list of resources with specific tag
resource_list=`az resource list --tag ${tag} --subscription ${subscription}`

# Get number of resources to be deleted
num_resources=`echo $resource_list | jq length`
echo 'Found' $num_resources 'resources'

# Delete resources
for((i=0; i<$num_resources; i++)); do
    # Get $i th resource name and type
    name=`echo $resource_list | jq .[$i].name | tr -d '"'`
    type=`echo $resource_list | jq .[$i].type | tr -d '"'`
    
    echo 'Deleting following resource ...'
    echo 'resource name': $name
    echo 'resource type': $type
    
    # Delete $i th resource
    az resource delete -g ${resource_group} -n ${name} --resource-type ${type}
done
