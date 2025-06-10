# Learn Linux by CTF

### Why forking

> This repo is a fork of [https://github.com/guye1296/learn-linux-by-ctf](https://github.com/guye1296/learn-linux-by-ctf).
I would like to thank guye1296 for his great job for the basic infrastructure which allows very easy creation of CTF docker images.

The main goal for this fork is using it as the basis for building one or more images for learning CTF for my students. 


This repo update the Docker file to use latest images and reduce final generated image.


### Goal 

Learn how to use a Linux commandline in a fun, gameful manner - by playing capture the flag!

This repo contains a series of challenges (lessons), each teaching one or more Linx command..
In order to complete the challenge, you must find a flag.

All my lessons will be in Italian and I have also translated the original challenges.


### Build

```bash
docker build -t <image name> .
docker image prune -f (optinal)
```

## Run

Assuming you have docker installed, run the following command:
```bash
docker run --rm -it <image name>
```
