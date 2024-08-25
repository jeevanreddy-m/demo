#!/bin/bash -ex
# -e Exit immediately if a command exits with a non-zero status.
# -x Print commands and their arguments as they are executed.

# get the region and environment from the plan filename
region_env_lower=$(echo ${PLAN_FILENAME} | grep -o '^[A-Za-z]*-[A-Za-z]*' | tr '[:upper:]' '[:lower:]')
rg_environment_lower=$(echo ${region_env_lower} | grep -o '^[a-z]*')
rg_region_lower=$(echo ${region_env_lower} | grep -o '[a-z]*$')
# set the terraform state file
tf_file_prefix="${rg_environment_lower}-${rg_region_lower}"
tfstate_file="${tf_file_prefix}.tfstate"
tf_apply_file="out.tfplan"

# login into Azure
az login --service-principal --username ${AZ_USER} -p="${AZ_PASSWORD}" --tenant ${AZ_TENANT_ID}

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

# initialize terraform
terraform init
# validate terraform scripts
terraform validate

# set output variables
echo "tf_file_prefix=${tf_file_prefix}" >> $GITHUB_OUTPUT
echo "tfstate_file=${tfstate_file}" >> $GITHUB_OUTPUT
echo "tf_apply_file=${tf_apply_file}" >> $GITHUB_OUTPUT
