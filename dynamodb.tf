#Create dynamodb

# <---------[On Demand]--------->

resource "aws_dynamodb_table" "dydb-terraform" {
  name = "coba"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "UserId" #Partition
  range_key = "TokenId" #Sort

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "TokenId"
    type = "S"
  }

#   tags = {
#     Name = "dynamo-terra"
#   }
}


# <---------[Provisioned]--------->

# #Test Dynamodb Provisioned Custom
# resource "aws_dynamodb_table" "prem-dynamo-terra" {
#   name           = "premterra"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 5
#   write_capacity = 5
#   hash_key       = "UserId"
#   range_key      = "TokenId"

#   attribute {
#     name = "UserId"
#     type = "S"
#   }

#   attribute {
#     name = "TokenId"
#     type = "S"
#   }

# #   tags = {
# #     Name = "premium-dynamo-terra"
# #   }
# }

# # Auto Scaling Target for Read Capacity
# resource "aws_appautoscaling_target" "dynamo_read_target" {
#   max_capacity       = 20
#   min_capacity       = 5
#   resource_id        = "table/${aws_dynamodb_table.prem-dynamo-terra.name}"
#   scalable_dimension = "dynamodb:table:ReadCapacityUnits"
#   service_namespace  = "dynamodb"
# }

# # Auto Scaling Policy for Read Capacity
# resource "aws_appautoscaling_policy" "dynamo_read_policy" {
#   name               = "DynamoDBReadScalingPolicy"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.dynamo_read_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.dynamo_read_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.dynamo_read_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value       = 70.0  # Target utilization (%)
#     predefined_metric_specification {
#       predefined_metric_type = "DynamoDBReadCapacityUtilization"
#     }
#     scale_in_cooldown  = 60
#     scale_out_cooldown = 60
#   }
# }

# # Auto Scaling Target for Write Capacity
# resource "aws_appautoscaling_target" "dynamo_write_target" {
#   max_capacity       = 15
#   min_capacity       = 5
#   resource_id        = "table/${aws_dynamodb_table.prem-dynamo-terra.name}"
#   scalable_dimension = "dynamodb:table:WriteCapacityUnits"
#   service_namespace  = "dynamodb"
# }

# # Auto Scaling Policy for Write Capacity
# resource "aws_appautoscaling_policy" "dynamo_write_policy" {
#   name               = "DynamoDBWriteScalingPolicy"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.dynamo_write_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.dynamo_write_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.dynamo_write_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value       = 75.0  # Target utilization (%)
#     predefined_metric_specification {
#       predefined_metric_type = "DynamoDBWriteCapacityUtilization"
#     }
#     scale_in_cooldown  = 60
#     scale_out_cooldown = 60
#   }
# }
