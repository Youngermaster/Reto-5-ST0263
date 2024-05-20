# ! Change the ec2-18-205-17-227.compute-1.amazonaws.com to your ec2 instance public DNS
ssh -i your_pem.pem -N -L 8888:ec2-18-205-17-227.compute-1.amazonaws.com:8888 hadoop@ec2-18-205-17-227.compute-1.amazonaws.com
