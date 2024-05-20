resource "aws_key_pair" "emr_key" {
  key_name   = "emr-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Cambia al path de tu llave pública
}

output "key_pair_name" {
  value = aws_key_pair.emr_key.key_name
}
