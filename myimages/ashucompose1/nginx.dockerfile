FROM nginx 
# refering docker standard image from docker hub 
LABEL email=ashutoshh@linux.com
COPY  webapp /usr/share/nginx/html/
# copy data of webapp directory to nginx document root 
# Note: cmd or entrypoint if we don't use then standard image cmd or entrypoint 
# will be automatically inherited 