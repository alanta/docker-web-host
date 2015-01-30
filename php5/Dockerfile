FROM octohost/php5

VOLUME /srv/www

EXPOSE 80

ADD default /etc/nginx/sites-available/

# add the startup script
ADD ./startup.sh /opt/

# Define default command.
CMD ["/bin/bash", "/opt/startup.sh"]

