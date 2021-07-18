resource "aws_instance" "Rabbit" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  key_name      = "epamclass"
  subnet_id = data.aws_subnet.public_subnet.id

  tags = {
    Name = "Rabbit"
  }
}

resource "null_resource" "ansible_automation" {
  triggers = {
    build_number = "${timestamp()}"
    }

  provisioner "local-exec" {
    command = "sleep 25; ansible-galaxy install -p ${path.root}/../ansible/roles -r ${path.root}/../ansible/requirements.yml --force && cd ../ansible && ansible-playbook --vault-password-file /var/lib/jenkins/mysecret.txt rabbit.yml -i aws_ec2.yaml --key-file ${var.key}"
  }
  depends_on = [
    aws_instance.Rabbit
  ]

}