# Multi tenant web hosting on CoreOS with Docker

This setup is a first attempt to use docker and CoreOS to setup a scalable multi-tenant web hosting cluster.

## How far along is it?
With this setup you can host a bunch of PHP/MySQL sites on a single CoreOS instance. 
Preliminary support for controlling (and restarting) the sites is in, using systemd units. Since Fleet builds on top of Systemd 
this is mostly working, though there seems to be an issue launching the PHP container.

## What's left to do?
* Improve automation and parameterization of scripts
* Improve this readme with details on how to start / launch services
* ASP.NET 5 support
* Work with multi-node clusters so sites can scale up

## Moving parts
So far, this repo has the following moving parts:

* HTTP Reverse proxy

  Dispatches requests based on domain names, based on [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy).
  
* MySQL

  The stock MySQL container wrapped in a systemd unit.

* PHP5

  Customized container that links to the mysql container and exposes the variables for your PHP application to configure itself.
  
## How to use this

1. Checkout this repo
2. Use fleet to loadup and start the basic services; mysql and web-proxy

   MySQL will store it's data under /home/core/mysql
3. Build the PHP5 container
4. Setup your site under /home/core/sites, for example using a Git repo
5. Customize the site template service file and start it with fleet
