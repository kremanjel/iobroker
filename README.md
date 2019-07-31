# docker-iobroker
Docker image for ioBroker (http://iobroker.net) based on node:lts (https://hub.docker.com/_/node)

This project creates a Docker image for running ioBroker in a Docker container. It is made for and tested on a Synology Disk Station 716+ with DSM 6 and Docker-package installed.

## Installation & Usage

A detailed tutorial (german) can be found here: [https://buanet.de](https://buanet.de/2019/05/iobroker-unter-docker-auf-der-synology-diskstation-v3/). Many thanks to buanet!


### Environment Variables

|env|value|description|
|---|---|---|
|PACKAGES|package1 package2 package2|seperateed by whitespace; will install the listed packages on startup<br>(be paitient, this may take some time!)|
|AVAHI|true|will install and activate avahi-daemon for supporting yahka-adapter|
|LANGUAGE|de_DE:de|following locales are pre-generated: de_DE:de, en_US:en|
|LANG|de_DE.UTF-8|following locales are pre-generated: de_DE.UTF-8, en_US.UTF-8|
|LC_ALL|de_DE|following locales are pre-generated: de_DE.UTF-8, en_US.UTF-8|
|TZ|Europe/Berlin|all valid Linux-timezones|

### Mounting Folder/ Volume

It is now possible to mount an empty folder to /opt/iobroker during first startup of the container. The Startupscript will check this folder and restore content if empty.

It is absolutely recommended to use a mounted folder or persistent volume for /opt/iobroker folder!

This also works with mounting a folder containing an existing ioBroker-installation (e.g. when moving an existing installation to docker). 


## Changelog

### v0.0.1 (2019-07-31)
* project started / initial release

## License

MIT License

Copyright (c) 2019 Jan Merkel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Credits

Inspired by https://github.com/buanet/docker-iobroker
