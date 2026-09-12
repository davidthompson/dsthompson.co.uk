variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID containing the DNS records."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{32}$", var.cloudflare_zone_id))
    error_message = "cloudflare_zone_id must be the 32-character hexadecimal Cloudflare zone ID."
  }
}

variable "dns_records" {
  description = "Additional DNS records or overrides keyed by a stable Terraform name. Record names must be fully qualified."
  type = map(object({
    name            = string
    type            = string
    ttl             = optional(number, 1)
    content         = optional(string)
    priority        = optional(number)
    proxied         = optional(bool)
    comment         = optional(string)
    tags            = optional(set(string))
    data            = optional(any)
    settings        = optional(any)
    private_routing = optional(bool)
  }))
  default = {}

  validation {
    condition = alltrue([
      for record in values(var.dns_records) : contains([
        "A", "AAAA", "CAA", "CERT", "CNAME", "DNSKEY", "DS", "HTTPS",
        "LOC", "MX", "NAPTR", "NS", "OPENPGPKEY", "PTR", "SMIMEA", "SRV",
        "SSHFP", "SVCB", "TLSA", "TXT", "URI"
      ], upper(record.type))
    ])
    error_message = "Each DNS record must use a type supported by Cloudflare."
  }

  validation {
    condition = alltrue([
      for record in values(var.dns_records) : record.ttl == 1 || (record.ttl >= 60 && record.ttl <= 86400)
    ])
    error_message = "TTL must be 1 (automatic) or between 60 and 86400 seconds."
  }
}
