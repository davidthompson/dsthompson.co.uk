# Cloudflare DNS with Terraform

This project adopts existing Cloudflare DNS records into Terraform. State is held
in the `dns-production` workspace in the `dsthompson` HCP Terraform project within
the `davidsthompson` organization.

## Prerequisites

- Terraform 1.7 or newer
- A scoped Cloudflare API token with `Zone:DNS:Edit` and `Zone:Zone:Read` for the
  target zone
- The zone ID from the Cloudflare dashboard

Do not use the Cloudflare global API key and do not put a token in a `.tfvars`
file. The provider reads `CLOUDFLARE_API_TOKEN` directly from the environment.

## Adopt the existing records

1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Replace the example zone ID. Existing records from the Cloudflare export are
   declared in `dns-records.tf`; `dns_records` can remain empty until adding or
   overriding a record.
3. Set the API token for the current PowerShell session:

   ```powershell
   $env:CLOUDFLARE_API_TOKEN = "your-token"
   ```

4. Initialise and check the configuration:

   ```powershell
   terraform init
   terraform fmt -check
   terraform validate
   ```

5. Copy `imports.tf.example` to `imports.tf`. Add one import block per record,
   using the matching map key and Cloudflare DNS record ID.
6. Preview the import:

   ```powershell
   terraform plan
   ```

   The plan should show imports and no record replacements or deletions. Adjust
   the declared values until any post-import changes are intentional.
7. Adopt the records:

   ```powershell
   terraform apply
   ```

8. Delete `imports.tf` after the import is committed to state. From then on,
   edit `terraform.tfvars` and use `terraform plan` followed by `terraform apply`.

An empty `dns_records` map does not delete existing Cloudflare records. Terraform
only changes records that have been declared and imported into this state.

## Finding record IDs

Cloudflare's API can list every record and its ID. With the environment variables
set, this PowerShell request returns the relevant fields:

```powershell
$headers = @{ Authorization = "Bearer $env:CLOUDFLARE_API_TOKEN" }
$uri = "https://api.cloudflare.com/client/v4/zones/$env:CLOUDFLARE_ZONE_ID/dns_records?per_page=500"
(Invoke-RestMethod -Uri $uri -Headers $headers).result |
  Select-Object id, type, name, content, ttl, proxied, priority
```

Set `CLOUDFLARE_ZONE_ID` only for this lookup; Terraform gets the zone ID from
`terraform.tfvars`.

## GitHub Actions

The `Terraform Cloudflare DNS` workflow plans Terraform changes on pull requests
and automatically applies the saved plan after changes reach `main`. Runs are
serialized to prevent concurrent state modifications.

Configure these repository Actions secrets under **Settings > Secrets and
variables > Actions**:

- `CLOUDFLARE_API_TOKEN`: the scoped account token with DNS Write access to only
  `dsthompson.co.uk`.
- `HCP_TERRAFORM_TOKEN`: an HCP Terraform team token with permission to read and
  write state in the `dns-production` workspace. A user token also works for
  initial setup, but a narrowly scoped team token is preferable for CI.

The HCP workspace must use **Local execution mode** because the GitHub runner
executes Terraform. The zone ID is non-secret and is set as
`TF_VAR_cloudflare_zone_id` in the workflow.

Protect `main` and require the pull-request Terraform check before merging. For
manual recovery, `workflow_dispatch` applies only when run from `main`.
