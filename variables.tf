# variable "cdn_profile" {
#   type        = any
#   default     = {}
#   description = "resource definition, default settings are defined within locals and merged with var settings"
# }
# variable "cdn_endpoint" {
#   type        = any
#   default     = {}
#   description = "resource definition, default settings are defined within locals and merged with var settings"
# }
# variable "cdn_endpoint_custom_domain" {
#   type        = any
#   default     = {}
#   description = "resource definition, default settings are defined within locals and merged with var settings"
# }

# locals {
#   default = {
#     # resource definition
#     cdn_profile = {
#       name = ""
#       tags = {}
#     }
#     cdn_endpoint = {
#       name                          = ""
#       is_http_allowed               = true
#       querystring_caching_behaviour = "IgnoreQueryString"
#       tags                          = {}
#     }
#     cdn_endpoint_custom_domain = {
#       name = ""
#       cdn_managed_https = {
#         certificate_type = ""
#         tls_version      = null
#       }
#       user_managed_https = {
#         key_vault_certificate_id = ""
#         tls_version              = null
#       }
#       tags = {}
#     }
#   }

#   # compare and merge custom and default values
#   cdn_endpoint_custom_domain_values = {
#     for cdn_endpoint_custom_domain in keys(var.cdn_endpoint_custom_domain) :
#     cdn_endpoint_custom_domain => merge(local.default.cdn_endpoint_custom_domain, var.cdn_endpoint_custom_domain[cdn_endpoint_custom_domain])
#   }

#   # merge all custom and default values
#   cdn_profile = {
#     for cdn_profile in keys(var.cdn_profile) :
#     cdn_profile => merge(local.default.cdn_profile, var.cdn_profile[cdn_profile])
#   }
#   cdn_endpoint = {
#     for cdn_endpoint in keys(var.cdn_endpoint) :
#     cdn_endpoint => merge(local.default.cdn_endpoint, var.cdn_endpoint[cdn_endpoint])
#   }
#   cdn_endpoint_custom_domain = {
#     for cdn_endpoint_custom_domain in keys(var.cdn_endpoint_custom_domain) :
#     cdn_endpoint_custom_domain => merge(
#       local.cdn_endpoint_custom_domain_values[cdn_endpoint_custom_domain],
#       {
#         for config in ["cdn_managed_https", "user_managed_https"] :
#         config => merge(local.default.cdn_endpoint_custom_domain[config], local.cdn_endpoint_custom_domain_values[cdn_endpoint_custom_domain][config])
#       }
#     )
#   }
# }

variable "cdn_frontdoor_profile" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_origin_group" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_origin" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_endpoint" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_custom_domain" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_route" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_firewall_policy" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_security_policy" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

locals {
  default = {
    // resource definition
    cdn_frontdoor_profile = {
      name                     = ""
      sku_name                 = "Standard_AzureFrontDoor"
      response_timeout_seconds = null
      tags                     = {}
    }
    cdn_frontdoor_origin_group = {
      name                                                      = ""
      restore_traffic_time_to_healed_or_new_endpoint_in_minutes = null
      session_affinity_enabled                                  = null
      load_balancing = {
        additional_latency_in_milliseconds = null
        sample_size                        = null
        successful_samples_required        = null
      }
      health_probe = {
        request_type = null
        path         = null
      }
    }
    cdn_frontdoor_origin = {
      name               = ""
      enabled            = true // created origin should be enabled by default
      http_port          = null
      https_port         = null
      origin_host_header = null
      priority           = null
      weight             = null
      private_link = {
        request_message = null
        target_type     = null
      }
    }
    cdn_frontdoor_endpoint = {
      name    = ""
      enabled = null
      tags    = {}
    }
    cdn_frontdoor_custom_domain = {
      name        = ""
      dns_zone_id = null
      tls = {
        certificate_type        = null
        minimum_tls_version     = null
        cdn_frontdoor_secret_id = null
      }
    }
    cdn_frontdoor_route = {
      name                            = ""
      forwarding_protocol             = null
      patterns_to_match               = ["/*"]            // define default
      supported_protocols             = ["Http", "Https"] // define default match all
      cdn_frontdoor_custom_domain_ids = null
      cdn_frontdoor_origin_path       = null
      cdn_frontdoor_rule_set_ids      = null
      enabled                         = null
      https_redirect_enabled          = null
      link_to_default_domain          = false // disable link to default domain
      cache = {
        query_string_caching_behavior = null
        query_strings                 = null
        compression_enabled           = null
        content_types_to_compress     = null
      }
    }
    cdn_frontdoor_firewall_policy = {
      name                              = ""
      enabled                           = null
      mode                              = "Prevention" // define default
      redirect_url                      = null
      custom_block_response_status_code = null
      custom_block_response_body        = null
      custom_rule = {
        name                           = ""
        action                         = "Block" // define default
        enabled                        = null
        priority                       = null
        rate_limit_duration_in_minutes = null
        rate_limit_threshold           = null
        match_condition = {
          selector           = null
          negation_condition = null
          transforms         = null
        }
      }
      managed_rule = {
        action    = "Block" // define default
        exclusion = {}
        override = {
          exclusion = {}
          rule = {
            enabled   = true // defined override should be enabled
            exclusion = {}
          }
        }
      }
      tags = {}
    }
    cdn_frontdoor_security_policy = {
      name = ""
      security_policies = {
        firewall = {
          association = {
            patterns_to_match = ["/*"]
            domain            = {}
          }
        }
      }
    }
  }

  // compare and merge custom and default values
  cdn_frontdoor_origin_group_values = {
    for cdn_frontdoor_origin_group in keys(var.cdn_frontdoor_origin_group) :
    cdn_frontdoor_origin_group => merge(local.default.cdn_frontdoor_origin_group, var.cdn_frontdoor_origin_group[cdn_frontdoor_origin_group])
  }
  cdn_frontdoor_origin_values = {
    for cdn_frontdoor_origin in keys(var.cdn_frontdoor_origin) :
    cdn_frontdoor_origin => merge(local.default.cdn_frontdoor_origin, var.cdn_frontdoor_origin[cdn_frontdoor_origin])
  }
  cdn_frontdoor_custom_domain_values = {
    for cdn_frontdoor_custom_domain in keys(var.cdn_frontdoor_custom_domain) :
    cdn_frontdoor_custom_domain => merge(local.default.cdn_frontdoor_custom_domain, var.cdn_frontdoor_custom_domain[cdn_frontdoor_custom_domain])
  }
  cdn_frontdoor_route_values = {
    for cdn_frontdoor_route in keys(var.cdn_frontdoor_route) :
    cdn_frontdoor_route => merge(local.default.cdn_frontdoor_route, var.cdn_frontdoor_route[cdn_frontdoor_route])
  }
  cdn_frontdoor_firewall_policy_values = {
    for cdn_frontdoor_firewall_policy in keys(var.cdn_frontdoor_firewall_policy) :
    cdn_frontdoor_firewall_policy => merge(local.default.cdn_frontdoor_firewall_policy, var.cdn_frontdoor_firewall_policy[cdn_frontdoor_firewall_policy])
  }
  cdn_frontdoor_security_policy_values = {
    for cdn_frontdoor_security_policy in keys(var.cdn_frontdoor_security_policy) :
    cdn_frontdoor_security_policy => merge(local.default.cdn_frontdoor_security_policy, var.cdn_frontdoor_security_policy[cdn_frontdoor_security_policy])
  }

  // deep merge of all custom and default values
  cdn_frontdoor_profile = {
    for cdn_frontdoor_profile in keys(var.cdn_frontdoor_profile) :
    cdn_frontdoor_profile => merge(local.default.cdn_frontdoor_profile, var.cdn_frontdoor_profile[cdn_frontdoor_profile])
  }
  cdn_frontdoor_origin_group = {
    for cdn_frontdoor_origin_group in keys(var.cdn_frontdoor_origin_group) :
    cdn_frontdoor_origin_group => merge(
      local.cdn_frontdoor_origin_group_values[cdn_frontdoor_origin_group],
      {
        for config in ["load_balancing", "health_probe"] :
        config => merge(local.default.cdn_frontdoor_origin_group[config], local.cdn_frontdoor_origin_group_values[cdn_frontdoor_origin_group][config])
      }
    )
  }
  cdn_frontdoor_origin = {
    for cdn_frontdoor_origin in keys(var.cdn_frontdoor_origin) :
    cdn_frontdoor_origin => merge(
      local.cdn_frontdoor_origin_values[cdn_frontdoor_origin],
      {
        for config in ["private_link"] :
        config => merge(local.default.cdn_frontdoor_origin[config], local.cdn_frontdoor_origin_values[cdn_frontdoor_origin][config])
      }
    )
  }
  cdn_frontdoor_endpoint = {
    for cdn_frontdoor_endpoint in keys(var.cdn_frontdoor_endpoint) :
    cdn_frontdoor_endpoint => merge(local.default.cdn_frontdoor_endpoint, var.cdn_frontdoor_endpoint[cdn_frontdoor_endpoint])
  }
  cdn_frontdoor_custom_domain = {
    for cdn_frontdoor_custom_domain in keys(var.cdn_frontdoor_custom_domain) :
    cdn_frontdoor_custom_domain => merge(
      local.cdn_frontdoor_custom_domain_values[cdn_frontdoor_custom_domain],
      {
        for config in ["tls"] :
        config => merge(local.default.cdn_frontdoor_custom_domain[config], local.cdn_frontdoor_custom_domain_values[cdn_frontdoor_custom_domain][config])
      }
    )
  }
  cdn_frontdoor_route = {
    for cdn_frontdoor_route in keys(var.cdn_frontdoor_route) :
    cdn_frontdoor_route => merge(
      local.cdn_frontdoor_route_values[cdn_frontdoor_route],
      {
        for config in ["cache"] :
        config => merge(local.default.cdn_frontdoor_route[config], local.cdn_frontdoor_route_values[cdn_frontdoor_route][config])
      }
    )
  }
  cdn_frontdoor_firewall_policy = {
    for cdn_frontdoor_firewall_policy in keys(var.cdn_frontdoor_firewall_policy) :
    cdn_frontdoor_firewall_policy => merge(
      local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy],
      {
        for config in ["custom_rule"] :
        config => keys(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config]) == keys(local.default.cdn_frontdoor_firewall_policy[config]) ? {} : {
          for key in keys(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config]) :
          key => merge(
            merge(local.default.cdn_frontdoor_firewall_policy[config], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key]),
            {
              for subconfig in ["match_condition"] :
              subconfig => keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key], subconfig, {})) == keys(local.default.cdn_frontdoor_firewall_policy[config][subconfig]) ? {} : {
                for subkey in keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key], subconfig, {})) :
                subkey => merge(local.default.cdn_frontdoor_firewall_policy[config][subconfig], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey])
              }
            }
          )
        }
      },
      {
        for config in ["managed_rule"] :
        config => keys(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config]) == keys(local.default.cdn_frontdoor_firewall_policy[config]) ? {} : {
          for key in keys(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config]) :
          key => merge(
            merge(local.default.cdn_frontdoor_firewall_policy[config], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key]),
            {
              for subconfig in ["override"] :
              subconfig => keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key], subconfig, {})) == keys(local.default.cdn_frontdoor_firewall_policy[config][subconfig]) ? {} : {
                for subkey in keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key], subconfig, {})) :
                subkey => merge(
                  merge(local.default.cdn_frontdoor_firewall_policy[config][subconfig], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey]),
                  {
                    for subsubconfig in ["rule"] :
                    subsubconfig => keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey], subsubconfig, {})) == keys(local.default.cdn_frontdoor_firewall_policy[config][subconfig][subsubconfig]) ? {} : {
                      for subsubkey in keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey], subsubconfig, {})) :
                      subsubkey => merge(local.default.cdn_frontdoor_firewall_policy[config][subconfig][subsubconfig], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey][subsubconfig][subsubkey])
                    }
                  }
                )
              }
            },
          )
        }
      }
    )
  }
  cdn_frontdoor_security_policy = {
    for cdn_frontdoor_security_policy in keys(var.cdn_frontdoor_security_policy) :
    cdn_frontdoor_security_policy => merge(
      local.cdn_frontdoor_security_policy_values[cdn_frontdoor_security_policy],
      {
        for config in ["security_policies"] :
        config => merge(
          merge(local.default.cdn_frontdoor_security_policy[config], local.cdn_frontdoor_security_policy_values[cdn_frontdoor_security_policy][config]),
          {
            for subconfig in ["firewall"] :
            subconfig => merge(
              merge(local.default.cdn_frontdoor_security_policy[config][subconfig], local.cdn_frontdoor_security_policy_values[cdn_frontdoor_security_policy][config][subconfig]),
              {
                for subsubconfig in ["association"] :
                subsubconfig => merge(local.default.cdn_frontdoor_security_policy[config][subconfig][subsubconfig], local.cdn_frontdoor_security_policy_values[cdn_frontdoor_security_policy][config][subconfig][subsubconfig])
              }
            )
          }
        )
      }
    )
  }
}
