resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "conversationId" = {
                "type" = "string"
            },
            "priority" = {
                "type" = "integer"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "priority" = {
                "description" = "The new priority of the in-queue conversation.",
                "type" = "integer"
            }
        },
        "type" = "object"
    })
    
    config_request {
        request_template     = "{ \"priority\": $${input.priority} }"
        request_type         = "PATCH"
        request_url_template = "/api/v2/routing/conversations/$${input.conversationId}"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}