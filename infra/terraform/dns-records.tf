locals {
  # Imported from dsthompson.co.uk.txt, exported by Cloudflare on 2026-09-12.
  # SOA and authoritative NS records are managed by Cloudflare and are omitted.
  exported_dns_records = {
    home_a = {
      name    = "home.dsthompson.co.uk"
      type    = "A"
      ttl     = 1
      content = "83.217.163.146"
      proxied = true
    }

    caa_issue_letsencrypt = {
      name    = "dsthompson.co.uk"
      type    = "CAA"
      ttl     = 1
      proxied = false
      data = {
        flags = 0
        tag   = "issue"
        value = "letsencrypt.org"
      }
    }

    caa_issuewild_letsencrypt = {
      name    = "dsthompson.co.uk"
      type    = "CAA"
      ttl     = 1
      proxied = false
      data = {
        flags = 0
        tag   = "issuewild"
        value = "letsencrypt.org; validationmethods=dns-01"
      }
    }

    apex_cname = {
      name    = "dsthompson.co.uk"
      type    = "CNAME"
      ttl     = 1
      content = "davidthompson.github.io"
      proxied = true
    }

    nas_cname = {
      name    = "nas.dsthompson.co.uk"
      type    = "CNAME"
      ttl     = 1
      content = "home.dsthompson.co.uk"
      proxied = true
    }

    www_cname = {
      name    = "www.dsthompson.co.uk"
      type    = "CNAME"
      ttl     = 1
      content = "davidthompson.github.io"
      proxied = true
    }

    mx_aspmx3 = {
      name     = "dsthompson.co.uk"
      type     = "MX"
      ttl      = 1
      content  = "aspmx3.googlemail.com"
      priority = 30
      proxied  = false
    }

    mx_aspmx2 = {
      name     = "dsthompson.co.uk"
      type     = "MX"
      ttl      = 1
      content  = "aspmx2.googlemail.com"
      priority = 30
      proxied  = false
    }

    mx_alt1 = {
      name     = "dsthompson.co.uk"
      type     = "MX"
      ttl      = 1
      content  = "alt1.aspmx.l.google.com"
      priority = 20
      proxied  = false
    }

    mx_alt2 = {
      name     = "dsthompson.co.uk"
      type     = "MX"
      ttl      = 1
      content  = "alt2.aspmx.l.google.com"
      priority = 20
      proxied  = false
    }

    mx_primary = {
      name     = "dsthompson.co.uk"
      type     = "MX"
      ttl      = 1
      content  = "aspmx.l.google.com"
      priority = 10
      proxied  = false
    }

    txt_dmarc = {
      name    = "_dmarc.dsthompson.co.uk"
      type    = "TXT"
      ttl     = 1
      content = "v=DMARC1; p=reject; rua=mailto:dsthompson-d@dmarc.report-uri.com; ruf=mailto:dsthompson-d@dmarc.report-uri.com; aspf=r; adkim=r"
      proxied = false
    }

    txt_spf = {
      name    = "dsthompson.co.uk"
      type    = "TXT"
      ttl     = 1
      content = "v=spf1 include:_spf.google.com ~all"
      proxied = false
    }

    txt_hibp_verification = {
      name    = "dsthompson.co.uk"
      type    = "TXT"
      ttl     = 1
      content = "have-i-been-pwned-verification=dc852d32d8c8c6b9f2393f82a2311b64"
      proxied = false
    }

    txt_google_site_verification = {
      name    = "dsthompson.co.uk"
      type    = "TXT"
      ttl     = 1
      content = "google-site-verification=M_W8PrdZEzHUcVC2SkukHWDzv4Cy0DZLnXoSvLInoo8"
      proxied = false
    }

    txt_google_dkim = {
      name    = "google._domainkey.dsthompson.co.uk"
      type    = "TXT"
      ttl     = 1
      content = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqOM4egSMI6uXqFAxtvptWUrDkGU+n+NpWYhtASgIatsiBc/Wbx29mR8/FfXsOM0cDyNIBnmbxcDauGnPUZkU6LXACzahcvvOtqHdj3fscWITz3m7FdTyAX54eNL6pel7rE660PdX5YJC8EqLhteqzqgcVftmIwnWg+sMVc6ovCMCf9wtrUPN851g2oemudQK10d4o6teHbaWST/KngAu3iBZxgqdQTH1wE6vdFbMbl+0mGiWs2byAmGt4IddZjWyUgpUklNMQcbHn6aYPMtNSIpoE1THj6Nuehg4JGUopphFac6t9mvLDrGtvoeHJ1lMO4+EuyOxEoLTTEte6Oj+pQIDAQAB"
      proxied = false
    }
  }
}
