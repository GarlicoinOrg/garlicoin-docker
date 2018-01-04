# Garlicoin Docker Build Environment

## Goal

Written to simplify dependency complexity and messiness contained in a miniature virtual machine

## Running

Install docker and docker-compose on your appropriate OS and start the docker daemon

For a development build you need to generate the compose file and dockerfile using the following command

```bash
./generate-dev-compose.sh /path/to/garlicoin
```

then you should be able to pull up the docker container using the following command

```bash
./garlicoin.sh -s dev
```

Use the -f flag to force a build regardless like so

```bash
./garlicoin.sh -f -s dev
```

the entrypoint script detects if it's been built before

you then should be able to connect to the container using the connect script

```bash
./garlicoin.sh -c dev
```

## Release

Release builds are simpler than the development build because it pulls from the HEAD of the garlicoin repo and automatically builds

```bash
./garlicoin.sh -s release
```

then connect as usual

```bash
./garlicoin.sh -c release
```