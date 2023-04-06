 # !/bin/bash

        # Set subscription
          az account set --subscription ${{ env.subscription }}

        # Get list of resources with specific tag
          resource_list= 'az resource list --tag ${{ env.tag }} --subscription ${{ env.subscription }}'

        # Get number of resources to be deleted
          num_resources='echo $resource_list | jq length'
         
        # Delete resources
          for((i=0; i<$num_resources; i++)); do
            # Get $i th resource name and type
            name='echo $resource_list | jq .[$i].name | tr -d '"''
            type='echo $resource_list | jq .[$i].type | tr -d '"''

            # Delete $i th resource
            az resource delete -g ${{ env.resource_group }} -n ${name} --resource-type ${type}
          done
