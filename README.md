# pitt-boss
This a template for using dotnet core + react + docker. No strings attached.

* Installation
  - Clone the project
    - git clone git@github.com:xrs1133/pitt-boss.git
  - OSX
    - Install docker for mac
    - https://docs.docker.com/docker-for-mac/install/
  
  Once you have installed docker for mac then drop to a terminal window.

  `cd /path/to/pitt-boss`
  `docker build --pull -t pitt-boss .`
  `docker run --name pitt-boss --rm -it -p 5000:80 pitt-boss`

  Now that it is running. Open a browser and navigate to `http://localhost:5000`
