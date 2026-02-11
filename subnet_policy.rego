package terraform

import rego.v1

# Evaluate Terraform plan JSON lines format
# Extracts the plan object and evaluates subnet policies

# Policy: All aws_subnet resources must use availability_zone = "sa-east-1b"
deny[msg] if {
    # Find resource_changes that contain aws_subnet resources
    change := input.resource_changes[_]
    change.type == "aws_subnet"
    
    # Get the resource configuration (after attribute)
    config := change.change.after
    config.availability_zone != "sa-east-1b"
    
    msg := sprintf(
        "Subnet resource '%s' has invalid availability_zone '%s'. Must be 'sa-east-1b'",
        [change.address, config.availability_zone]
    )
}

# Alternative: Check only for create/update operations
deny_changes[msg] if {
    change := input.resource_changes[_]
    change.type == "aws_subnet"
    change.change.actions[_] != "no-op"  # Only flag if creating or updating
    
    config := change.change.after
    config.availability_zone != "sa-east-1b"
    
    msg := sprintf(
        "Subnet '%s' change violates policy: availability_zone must be 'sa-east-1b' (got '%s')",
        [change.address, config.availability_zone]
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
