# data "aws_ami" "image" {
#   most_recent      = true
#   owners           = ["self"]
	
# 	filter {
#     name   = "name"
#     values = ["packer-mongodb-*"]
#   }
# }

# resource "aws_instance" "mongodb" {
#     ami = "${data.aws_ami.image.id}"
# 		instance_type = "t2.micro"
#     subnet_id = "${aws_subnet.main-subnet-public-1.id}"
#     vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
# 		key_name = "${aws_key_pair.deployer.id}"
# 		tags = {
# 			Name = "packer Mongo"
# 		}

# 		connection {
# 						type = "ssh"
#             user = "ubuntu"
#             private_key = "${file("/Users/srikanthkatta/.ssh/id_rsa")}"
#             host = "${self.public_ip}"
#         }

# 		provisioner "remote-exec" {
# 			inline = [
# 				"sudo systemctl daemon-reload",
# 				"sudo systemctl start mongod",	
# 			]
# 		}
#   }
		
# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key1"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqxETkdUeivkPRc77KkLeN6O/AgJGTNE89+f3exHvh8G9exSyc7SAigXHXxbDOaMvbWSM0c3Y/XIbleCeTl8gkj1i+LfMvqkhpa9q7kEJ6O8Ri1ZZL6hJZ9mC3WAc7b5trHsabaXUejhWllPIx//LqzzIiZBm+LdnKrTImuSRdHEXB0peFWXpOoJO+Pfn0Y1tMJPtrOUHssrLt3nc5rCdwm83IlZsazRl+Jw6HvUa3I/dswZoOt0YT2Y590/aJ7gYWj0vJ4DBQJLrwYeyFNGX+I6iUg42hjZbhzzBgFeuLLFpi5WktT1Jh9deVYx9p8LwgiS9D3tiXuf2kVWxDrZ/T srikanthkatta@Administrators-MacBook-Pro-9.local"
# }

module "terraform-mongodb" {
  source = "../terraform-monodb/"
  ami = "ami-0091d303b9f45e661"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-subnet-public-1.id
  vpc_security_group_ids=[aws_security_group.ssh-allowed.id]
  key_name="deployer-key1"
  tags = {
    Name = "New packer mongo"
  }
}