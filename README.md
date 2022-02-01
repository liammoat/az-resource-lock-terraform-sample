# Azure Resource Lock Terraform Sample

## Deployment

### Variables

* **prefix** *(optional)* - string
* **location** *(optional)* - string
* **env** - string
* **enable_locks** - bool

### Examples

**Deploy with locks disabled**

```
terraform apply \
    -var env=dev \
    -var enable_locks=false
```

**Deploy with locks enabled**

```
terraform apply \
    -var env=prod \
    -var enable_locks=true
```