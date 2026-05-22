aws_region   = "us-east-1"
project_name = "borderless-hms"
environment  = "production"

postgres_password = "H0sp1talDev2024!"
jwt_secret_key    = "20758fa9f296b14d1fd970d4f273f29c2718bbb653c4f3dc7e63c7a10c36b5ce"

rds_multi_az       = true
rds_instance_class = "db.t3.medium"

backend_min_tasks  = 2
backend_max_tasks  = 20
frontend_min_tasks = 2
frontend_max_tasks = 10
