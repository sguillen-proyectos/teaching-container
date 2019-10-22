Teaching Container
===

This is an experimental project that uses some not-recommended practices in Docker containers such as having init services like systemd or remote control  services such as OpenSSH. Docker containers are supposed to run only one application or service per container, this projects is the opposite and not recommended for **production**.

The reason of this project is to use it when I do trainings. Generally I create a server-per-user training, but when I give free trainings I want to reduce costs but still give students a VPS-like environment where they can SSH, install, configure, etc.

## How to Run
This docker image can run just as any other, the difference is that it needs to run as a `privileged` container and a read-only volume binding `/sys/fs/cgroup`

```
$ docker run -d --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro sergioguillen/teaching-container:latest
```


## Creation of `debian-systemd-base`
You might have noticed that there is no `Dockerfile` for `sergioguillen/debian-systemd-base:stretch` image. It is a base image that was created from scratch based on a base rootfs that has all the necessary components for `systemd` to start and run as expected.

The way to create this base image is:

```
$ mkdir -p debian-systemd-base
$ sudo debootstrap stretch debian-systemd-base
$ sudo tar -C debian-systemd-base -c . | docker import - sergioguillen/debian-systemd-base:stretch
```
Basically the previous method is very common when creating custom LXD images, so technically it is an LXD procedure used to create a Docker image :P

The reason I used that method is that creating my Dockerfile based on `debin:stretch` and installing `systemd` packages was that after I installed a new service e.g. `nginx` or `openssh-server` the systemd service for those recently installed services didn't start automatically as expected. Maybe a missing configuration, so a quick method was to create a Docker image using a `rootfs` that has all the systemd components on-place.
