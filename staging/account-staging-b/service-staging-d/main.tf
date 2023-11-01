resource "aws_instance" "example_server" {
  ami           = "ami-0b0f138edf421d756"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform test service staging-d"
  }
}