terraform {
  cloud {
    organization = "davidsthompson"

    workspaces {
      project = "dsthompson"
      name    = "dns-production"
    }
  }
}
