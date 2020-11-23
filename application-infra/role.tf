//data "aws_iam_policy_document" "ecs_task_policy_doc" {
//  statement {
//    effect = "Allow"
//    actions = [
//      "elasticache:*"
//    ]
//    resources = [module.redis.redis_arn]
//  }
//}
//
//resource "aws_iam_policy" "ecs_task_policy" {
//  name   = "redis-access"
//  path   = "/"
//  policy = data.aws_iam_policy_document.ecs_task_policy_doc.json
//}
//
//resource "aws_iam_role_policy_attachment" "ecs_to_redis" {
//  role       = module.role.ecs-instance-profiel-role-name
//  policy_arn = aws_iam_policy.ecs_task_policy
//}