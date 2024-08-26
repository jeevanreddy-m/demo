#!/bin/bash
# -e Exit immediately if a command exits with a non-zero status.
# -x Print commands and their arguments as they are executed.

# get the region and environment from the plan filename
region_env_lower=$(echo ${PLAN_FILENAME} | grep -o '^[A-Za-z]*-[A-Za-z]*' | tr '[:upper:]' '[:lower:]')
rg_environment_lower=$(echo ${region_env_lower} | grep -o '^[a-z]*')
rg_region_lower=$(echo ${region_env_lower} | grep -o '[a-z]*$')
# set the terraform state file
tf_file_prefix="${rg_environment_lower}-${rg_region_lower}"
echo "before state file prefix: ${tf_file_prefix}"
tfstate_file="${tf_file_prefix}.tfstate"
tf_apply_file="out.tfplan"
tfvars_file="${tf_file_prefix}-tfvars.json"

# login into Azure
az login --service-principal --username ${AZ_USER} -p="${AZ_PASSWORD}" --tenant ${AZ_TENANT_ID}

WORKING_DIR="/home/runner/work/demo/demo/terraform"
# Print the current working directory
echo "Current working directory: $(pwd)"
# Attempt to change directory
cd "$WORKING_DIR" || { echo "Failed to change directory to $WORKING_DIR"; exit 1; }

# check if the terraform state file exists in Azure
tfstate_file_status=$(az storage blob exists --account-name ${AZ_TERRAFORM_STORAGE_ACCOUNT} \
--container-name tfstate \
--name ${tfstate_file} \
--auth-mode key \
--account-key ${AZ_TERRAFORM_STORAGE_KEY})
if [[ ${tfstate_file_status} =~ .*'"exists"'.*'true'.* ]]; then
# download state file, which contains the latest Azure state
az storage blob download --account-name ${AZ_TERRAFORM_STORAGE_ACCOUNT} \
--container-name tfstate \
--name ${tfstate_file} \
--file terraform.tfstate \
--auth-mode key \
--account-key ${AZ_TERRAFORM_STORAGE_KEY}
fi

# download tfplan file and name the downloaded file 'out.tfplan'
az storage blob download --account-name ${AZ_TERRAFORM_STORAGE_ACCOUNT} \
--container-name tfplan \
--name ${PLAN_FILENAME} \
--file ${tf_apply_file} \
--auth-mode key \
--account-key ${AZ_TERRAFORM_STORAGE_KEY}

# download file with environment/region specific variables
# the file "terraform.tfvars.json" is automatically used by terraform plan
az storage blob download --account-name ${AZ_TERRAFORM_STORAGE_ACCOUNT} \
--container-name tfvars \
--name ${tfvars_file} \
--file terraform.tfvars.json \
--auth-mode key \
--account-key ${AZ_TERRAFORM_STORAGE_KEY}

# initialize terraform
terraform init
# validate terraform scripts
terraform validate


#terraform_variables_file="env-${TARGET_ENV}.tfvars"
#terraform_variables_file="terraform.tfvars.json"

echo "Current working directory: $(pwd)"
# export TF_LOG=DEBUG
#terraform apply -auto-approve
terraform import module.resource-group.azurerm_resource_group.rg /subscriptions/9bf7ac78-0625-49e4-9fe2-4f36dd943a48/resourceGroups/github-terraform-rg1


#function get_az_resource_name() {
#
#local ecommerce_tag_id=$1
#
#if [[ $ecommerce_tag_id == "" ]];
#then
#echo "Error: missing argument 'e-commerce tag id'"
#else
#echo "Searching for resource with the tag 'e-commerce-id' value of '${ecommerce_tag_id}'"
#
#retval=$(az resource list --tag "e-commerce-id=${ecommerce_tag_id}" --query "[].{name:name}" -o tsv)
#fi
#}
#
#function get_terraform_resource_path_by_name() {
#
#local resource_provider=$1
#local resource_collection=$2
#local resource_name=$3
#
#if [[ $resource_provider == "" ]];
#then
#echo "Error: missing argument 'resource provider'"
#else
#if [[ $resource_collection == "" ]];
#then
#echo "Error: missing argument 'resource collection'"
#else
#if [[ $resource_name == "" ]];
#then
#echo "Error: missing argument 'resource name'"
#else
#retval="/subscriptions/${ARM_SUBSCRIPTION_ID}/resourceGroups/${AZ_TARGET_RG}/providers/${resource_provider}/${resource_collection}/${resource_name}"
#fi
#fi
#fi
#}
#
#function get_terraform_resource_path_by_ecommerce_tag() {
#
#local resource_provider=$1
#local resource_collection=$2
#local ecommerce_tag_id=$3
#
#get_az_resource_name $ecommerce_tag_id
#
#if [[ $retval == "" ]];
#then
#echo "Error: resource not found with e-commerce tag id '${ecommerce_tag_id}'"
#else
#echo "Resource found: '${retval}'"
#
#get_terraform_resource_path_by_name $resource_provider $resource_collection $retval
#fi
#}
#
#function get_storage_url() {
#
#local storage_name=$1
#
#if [[ $storage_name == "" ]];
#then
#echo "Error: missing argument 'storage name'"
#else
#storage_url=$(az storage account show -n $storage_name --query primaryEndpoints.web -o tsv)
#
#echo "Found storage account url: $storage_url"
#
#retval=$storage_url
#fi
#}
#
#echo "Current working directory: $(pwd)"
#terraform apply -auto-approve
#terraform import module.resource-group.azurerm_resource_group.rg /subscriptions/9bf7ac78-0625-49e4-9fe2-4f36dd943a48/resourceGroups/github-terraform-rg1

## lookup key vault
#get_terraform_resource_path_by_ecommerce_tag "Microsoft.KeyVault" "vaults" $AZ_KEYVAULT_TAG
#keyvault_terraform_path=$retval
#
## import key vault
#echo "Importing terraform resource with: $keyvault_terraform_path"
#terraform import -var-file=$terraform_variables_file azurerm_key_vault.kv $keyvault_terraform_path
#
## lookup storage account
#get_az_resource_name $AZ_TERRAFORM_STORAGE_ACCOUNT_TAG
#storage_name=$retval
#
#get_terraform_resource_path_by_name "Microsoft.Storage" "storageAccounts" $storage_name
#storage_terraform_path=$retval
#
## import storage account
#echo "Importing terraform resource with: $storage_terraform_path"
#terraform import -var-file=$terraform_variables_file azurerm_storage_account.tfstate $storage_terraform_path
#
## lookup storage container
#get_storage_url $storage_name
#storage_url=$retval
#
#storage_container_terraform_path="${storage_url}infrastructure"
#echo "Importing terraform resource with: $storage_container_terraform_path"
#
## import storage container
#terraform import -var-file=$terraform_variables_file azurerm_storage_container.infrastructure_tfstate_container $storage_container_terraform_path
echo "tf state file name : ${tfstate_file}"
# set output variables
echo "tf_file_prefix=${tf_file_prefix}" >> $GITHUB_OUTPUT
echo "tfstate_file=${tfstate_file}" >> $GITHUB_OUTPUT
echo "tf_apply_file=${tf_apply_file}" >> $GITHUB_OUTPUT
