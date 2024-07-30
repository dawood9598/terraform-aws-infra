resource "aws_sns_topic" "devops_exercise" {
  name                        = "devops_exercise.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
}

resource "aws_sns_topic_subscription" "user_email" {
  topic_arn = aws_sns_topic.devops_exercise.arn
  protocol  = "email"
  endpoint  = "example@gmail.com"
}