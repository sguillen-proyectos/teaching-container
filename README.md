Teaching Container
===

This is an experimental project that uses some not-recommended practices in Docker containers such as having init services like systemd or remote control  services such as OpenSSH. Docker containers are supposed to run only one application or service per container, this projects is the opposite and not recommended for **production**.

The reason of this project is to use it when I do trainings. Generally I create a server-per-user training, but when I give free trainings I want to reduce costs but still give students a VPS-like environment where they can SSH, install, configure, etc.
