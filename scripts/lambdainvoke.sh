#!/bin/bash
aws lambda invoke --function-name nivel1_app_logs --payload fileb://paths3lambda.json --invocation-type RequestResponse output.json
