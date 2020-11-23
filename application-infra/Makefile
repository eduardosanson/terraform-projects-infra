init-prod: clean
	~/terraform_0.12.24/terraform init -backend-config=backend-prod.tfvars; \
	~/terraform_0.12.24/terraform workspace new prod || ~/terraform_0.12.24/terraform workspace select prod

prod-workspace:
	~/terraform_0.12.24/terraform workspace new prod || ~/terraform_0.12.24/terraform workspace select prod

apply-prod: init-prod prod-workspace apply

apply:
	~/terraform_0.12.24/terraform apply -var-file="variable-prod.json"

plan:
	~/terraform_0.12.24/terraform plan -var-file="variable-prod.json"

clean:
	rm -rf .terraform

destroy:
	~/terraform_0.12.24/terraform destroy -var-file="variable-prod.json"

validate:
	~/terraform_0.12.24/terraform init -backend=false && ~/terraform_0.12.24/terraform validate