Amazon::Ecs.options = {
  :associate_tag => Rails.application.secrets.amazon_associate_tag,
  :AWS_access_key_id => Rails.application.secrets.aws_access_key_id,
  :AWS_secret_key => Rails.application.secrets.aws_secret_key
}