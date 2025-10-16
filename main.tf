resource "aws_instance" "ec2_instance" {
  count = var.instance_count

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = length(var.subnet_ids) > 0 ? var.subnet_ids[count.index % length(var.subnet_ids)] : null
  iam_instance_profile   = var.iam_instance_profile

  # User data script (optional)
  user_data = var.user_data

  # Root block device configuration
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    encrypted             = var.root_volume_encrypted
    delete_on_termination = true
  }

  tags = merge(
    {
      Name        = var.instance_count > 1 ? "${var.project_name}-${var.environment}-${count.index + 1}" : "${var.project_name}-${var.environment}"
      Project     = var.project_name
      Environment = var.environment
    },
    var.additional_tags
  )
}