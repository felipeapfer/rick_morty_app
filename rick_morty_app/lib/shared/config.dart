import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get AWS_USER_POOL_ID => dotenv.env['AWS_USER_POOL_ID'] ?? '';
  static String get AWS_USER_POOL_CLIENT_ID =>
      dotenv.env['AWS_USER_POOL_CLIENT_ID'] ?? '';
  static String get AWS_REGION => dotenv.env['AWS_REGION'] ?? '';
}
/* Staging Novo
AWS_USER_POOL_ID="us-east-2_usz5kAEnl"
AWS_USER_POOL_CLIENT_ID="3hf585kq9ji7s1hceq17gnhhkl"
AWS_REGION="us-east-2" */

/* - Staging no ar
AWS_USER_POOL_ID="us-east-2_xXZpRuFQ0"
AWS_USER_POOL_CLIENT_ID="6h94cm7823gbrlonbssdm3qro9"
AWS_REGION="us-east-2"

 */