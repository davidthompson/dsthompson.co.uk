resource "cloudflare_dns_record" "record" {
  for_each = merge(local.exported_dns_records, var.dns_records)

  zone_id         = var.cloudflare_zone_id
  name            = each.value.name
  type            = upper(each.value.type)
  ttl             = try(each.value.ttl, 1)
  content         = try(each.value.content, null)
  priority        = try(each.value.priority, null)
  proxied         = try(each.value.proxied, null)
  comment         = try(each.value.comment, null)
  tags            = try(each.value.tags, null)
  data            = try(each.value.data, null)
  settings        = try(each.value.settings, null)
  private_routing = try(each.value.private_routing, null)
}
