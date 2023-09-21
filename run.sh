echo '-------------------------------------------------------------'
echo '     Please wait 2-5 mins until the new prompt message       '
echo '-------------------------------------------------------------'

# Define Environment Variables
export LOCATION=eastus
export VM_IMAGE=Ubuntu2204

# Prompt the operator for input
read -p "Enter Resource Group Name: " RESOURCE_GROUP_NAME
read -p "Enter VM username: " ADMIN_USERNAME
read -p "Enter VM Name: " VM_NAME

# Use the input variables as needed
echo "Resource Group Name: $RESOURCE_GROUP_NAME"
echo "Location: $LOCATION"
echo "VM Name: $VM_NAME"
echo "VM Image: $VM_IMAGE"
echo "Admin Username: $ADMIN_USERNAME"

#---------------------------------------------------------#
#Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

#Create virtual machine
az vm create \
  --resource-group $RESOURCE_GROUP_NAME \
  --name $VM_NAME \
  --image $VM_IMAGE \
  --admin-username $ADMIN_USERNAME \
  --generate-ssh-keys \
  --public-ip-sku Standard
  --custom-script-extension \
    name="customScript" \
    location="$RESOURCE_GROUP_NAME" \
    file-path="customConfig.json" \
    type="RunOnce"
    
#Retrieve and store the IP address
export IP_ADDRESS=$(az vm show --show-details --resource-group $RESOURCE_GROUP_NAME --name $VM_NAME --query publicIps --output tsv)

# Setup "Environment"
az network security-rule create \
  --name allow-http \
  --resource-group $RESOURCE_GROUP_NAME \
  --priority 100 \
  --direction inbound \
  --protocol tcp \
  --source-address-prefix "*" \
  --destination-port-range 80

# Done
echo '-------------------------------------------------------------'
echo '     Setup Completed You can continue for the next step      '
echo '-------------------------------------------------------------'
