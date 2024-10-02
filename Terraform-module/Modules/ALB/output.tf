// output DNS of load balancer 
output "lb_dns" {
  description = "The DNS of the application load balancer"
  value = aws_lb.alb.dns_name
}


