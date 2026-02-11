package terraform

import rego.v1

# Evaluate Terraform plan JSON lines format
# Extracts the plan object and evaluates subnet policies

# Policy: All aws_subnet resources must use AWS_REGION = "sa-east-1"
deny[msg] if {
    # Find resource_changes that contain aws_subnet resources
    change := input.resource_changes[_]
    change.type == "aws_subnet"
    
    # Get the resource configuration (after attribute)
    config := change.change.after
    config.region != "sa-east-1"
    
    msg := sprintf(
        "Subnet resource '%s' is not in correct region '%s'. Must be 'sa-east-1'",
        [change.address, config.region]
    )
}

# Alternative: Check only for create/update operations
deny_changes[msg] if {
    change := input.resource_changes[_]
    change.type == "aws_subnet"
    change.change.actions[_] != "no-op"  # Only flag if creating or updating
    
    config := change.change.after
    config.region != "sa-east-1"
    
    msg := sprintf(
        "Subnet '%s' change violates policy: region must be 'sa-east-1' (got '%s')",
        [change.address, config.region]
    )
}

# Summary: returns statistics about the plan
summary[key] := value if {
    key := "total_subnets"
    value := count([c | input.resource_changes[c]; c.type == "aws_subnet"])
}

summary[key] := value if {
    key := "violations"
    value := count(deny)
}

# Compliance check
compliant if {
    count(deny) == 0
}
