output "REGION" {
  value = var.REGION
}

output "PROJECT_NAME" {
  value = var.PROJECT_NAME
}

output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUB_SUB_1_A_ID" {
  value = aws_subnet.public01.id
}
output "PUB_SUB_2_B_ID" {
  value = aws_subnet.public02.id
}
output "PRI_SUB_3_A_ID" {
  value = aws_subnet.private01.id
}

output "PRI_SUB_4_B_ID" {
  value = aws_subnet.private02.id
}
output "IGW_ID" {
    value = aws_internet_gateway.igw.id
}