  az vm extension set \
  --resource-group $RESOURCE_GROUP_NAME \
  --vm-name $VM_NAME \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["customConfig.sh"], "commandToExecute": "./customConfig.sh"}'