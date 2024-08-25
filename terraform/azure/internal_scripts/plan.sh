#!/bin/bash -ex
# -e Exit immediately if a command exits with a non-zero status.
# -x Print commands and their arguments as they are executed.

# convert environment and region to lower case
rg_environment_lower=$(echo ${RG_ENVIRONMENT} | tr '[:upper:]' '[:lower:]')
rg_region_lower=$(echo ${RG_REGION} | tr '[:upper:]' '[:lower:]')
# set destroy status
if [ ${PLAN_DESTROY_STATUS} == 'destroy' ]; then
destroy_status="-destroy"
else
destroy_status=""
fi

# set tf files
tf_file_prefix="${rg_environment_lower}-${rg_region_lower}"
tfstate_file="${tf_file_prefix}.tfstate"
tfvars_file="${tf_file_prefix}-tfvars.json"
tfplan_file="${tf_file_prefix}-$(date +"%Y%m%dT%H%M%S")-${WORKFLOW_RUN_NUMBER}-${WORKFLOW_USER}${destroy_status}.tfplan"

# login into Azure
echo "The User is: ${AZ_USER} and password: is ${AZ_PASSWORD} and tenant is: ${AZ_TENANT_ID}"
az login --service-principal --username ${AZ_USER} -p="${AZ_PASSWORD}" --tenant ${AZ_TENANT_ID}

#Testing Eventhub access through github actions
#az eventhubs eventhub show --resource-group ba-n-zeaus-orion-spl-rg --namespace-name ba-n-elm-001-ext-prmry-evhns --name n-fltplnnext_all_logs-evh

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

# set output variables
echo "rg_environment_lower=${rg_environment_lower}" >> $GITHUB_OUTPUT
echo "rg_region_lower=${rg_region_lower}" >> $GITHUB_OUTPUT
echo "destroy_status=${destroy_status}" >> $GITHUB_OUTPUT
echo "tfplan_file=${tfplan_file}" >> $GITHUB_OUTPUT