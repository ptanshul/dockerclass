FROM nginx:alpine

# Copy static website content
COPY index.html /usr/share/nginx/html/

# Document the port NGINX listens on
EXPOSE 80
