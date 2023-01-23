terraform {
    required_version = "1.3.7"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.51.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_instance" "dev" {
    count = 3 /*Aqui determinamos a quantidade de maquinas vituais queremos criar*/ 
    ami = "ami-00874d747dde814fa" /*A informação da ami pode ser encontrada na aws pelo Launch an instance e clicando na imagem desejada, no caso ami do Ubuntu*/
    instance_type = "t2.micro" /*a instância free tier da AWS*/
    key_name = "terraform-aws" /*Aqui vamos utilizar um ssh local para não ter que ficar preso a AWS, podendo utilizar a mesma chave ssh para diversas distribuições diferentes, como a Azure e GCP. Para fazer isso entramos no diretório raiz do projeto e digitamos: ssh-keygen -f terraform-aws -t rsa*/
    /*Após a criação da chave, precisamos importar para a aws(aws neste caso, pois é a distribuição que estamos utilizando) entrando no EC2, clicando em "Key pairs" e em actions: Import key pair*/
    tags = {
      "Name" = "dev${count.index}" /*A tag dessa forma nomeia cada máquina com seu index, no casa maquina 0, maquina 1 e maquina 2. Isso ocorre porque estamos criando 3 máquinas virtuais.*/
    }
}