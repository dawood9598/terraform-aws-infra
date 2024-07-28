resource "aws_sns_topic" "devops-exercise" {
  name                        = "devops-exercise.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "http"
  endpoint  = aws_sqs_queue.user_updates_queue.arn
}