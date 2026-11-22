terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_cloudwatch_dashboard" "perf_dashboard" {
  dashboard_name = "Project21-Performance-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title   = "EC2 CPU Utilization (%)"
          view    = "timeSeries"
          stacked = false
          region  = "ap-south-1"
          metrics = [
            ["AWS/EC2", "CPUUtilization", { stat = "Average", period = 60 }]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title   = "EC2 Network Traffic (Bytes)"
          view    = "timeSeries"
          stacked = false
          region  = "ap-south-1"
          metrics = [
            ["AWS/EC2", "NetworkIn", { stat = "Average", period = 60 }],
            ["AWS/EC2", "NetworkOut", { stat = "Average", period = 60 }]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 24
        height = 6
        properties = {
          title   = "ALB Request Count & Target Response Time"
          view    = "timeSeries"
          stacked = false
          region  = "ap-south-1"
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", { stat = "Sum", period = 60 }],
            ["AWS/ApplicationELB", "TargetResponseTime", { stat = "Average", period = 60 }]
          ]
        }
      }
    ]
  })
}
