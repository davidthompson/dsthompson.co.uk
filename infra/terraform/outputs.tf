output "managed_dns_records" {
  description = "Cloudflare IDs for records managed by this configuration."
  value = {
    for key, record in cloudflare_dns_record.record : key => {
      id   = record.id
      name = record.name
      type = record.type
    }
  }
}

