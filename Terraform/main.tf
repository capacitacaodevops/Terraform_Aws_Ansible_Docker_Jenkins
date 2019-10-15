resource "aws_instance" "web" {
 
    ami = "ami-02c8813f1ea04d4ab"
 
    instance_type = "t2.micro"

    key_name = "Web_SP"

    associate_public_ip_address = true
 
    tags {
 
        Name = "Web Server Teste"
 
         }
    subnet_id = "subnet-8cf742d7"

 
}
