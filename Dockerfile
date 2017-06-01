FROM nginx
# This mess because 'COPY' for a directory can flatten if we aren't this
# explicit
COPY ./css/ /usr/share/nginx/html/css/
COPY ./lib/ /usr/share/nginx/html/lib/
COPY ./imgs/ /usr/share/nginx/html/imgs
COPY ./js/ /usr/share/nginx/html/js
COPY ./terms/ /usr/share/nginx/html/terms
COPY ./raw_data/ /usr/share/nginx/html/raw_data
COPY ./plugin/ /usr/share/nginx/html/plugin
COPY ./LICENSE ./index.html /usr/share/nginx/html/
