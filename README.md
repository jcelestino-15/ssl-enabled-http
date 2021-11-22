# SSL Configuration 
After last weeks [lecture](https://github.com/CIT384/class-material/tree/main/LectureNotes/Nov_17) about SSL, this lab we are going to create a docker image that contains an apache web server which is configured to serve https://site1.internal. We will also be using rewrite rule to force https connections to our website. This means if a user types http://site1.internal it will be rewritten https://site1.internal 


# Making and trusting your own certificates
It is possible to make your own certificate without help from a CA. The certificate you make yourself will not be trusted by anyone else and is good for local development. There are several ways to setup self signed certificates for this lab we will use [OpenSSL](https://www.openssl.org/).

# Let's get started
You may use files from the previous lab as a skeleton.  

## Create vHost file
Update/create a vHost file for site1.internal
 - Turn [SSLEngine](https://httpd.apache.org/docs/2.4/mod/mod_ssl.html) On
 - Add [RewriteRule](https://httpd.apache.org/docs/2.4/mod/mod_rewrite.html) to force https://site1.internal
 - Add a new Block to handle 443 traffic  


 Example virtual host file with both port 80 and 443 block:
```
  # This block handles port 80 (HTTP) traffic
  <VirtualHost *:80>
   Place instructions here... 
  </VirtualHost> 

  # This block handles port 443 (HTTPS) traffic
  <VirtualHost *:443>
   Place instructions releated to SSL here... 
   Hint:
   SSLCertificateFile <path>
   SSLCertificateKeyFile <path> 
  </VirtualHost>
```
 - 

## Create/Update index.html file
We need to have a generic page to serve. You can either use one of the index.html files from the previous lab or create a new one. Be sure to place the index.html file in the appropriate location. 

## Create Dockerfile
 You may use any base image as your starting point. Your Dockerfile instructions may vary depending on what base image you use but should contain most of the following steps:
 - install Apache2 and any other necessary packages/modules
 - Enable any necessary Apache2 modules 
 - Create self signed certificates and place them in the appropriate locations
 - Copy vHost file to the appropriate location 
 - Copy index.html file to the appropriate location


## Testing
Be sure to test your Dockerfile: 
 - Build the docker image
 - Run a container from the docker image
 - Test via CLI or browser to ensure https is setup and working as expected
 - Test rewrite rule to verify http://site1.internal is rewritten to https://site1.internal

Example docker command with --add-host flag:
docker run --rm -it --add-host="site1.internal:127.0.0.1" -p 8080:80 -p 8443:443 docker_image /bin/bash

# Submission
Your submission should contain but is not limited to the following files:
 - Dockerfile
 - Updated Vhost file
 - index.html file

Any files that are used in a `COPY` statement should be commited to Git