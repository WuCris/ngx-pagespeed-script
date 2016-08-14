#!/bin/bash

# Fail is errors occur.
set -e
# Edit Nginx and Pagespeed versions here if different version is desired.
NGINX_VERSION=nginx-1.10.1
# Pagespeed version
PAGESPEED_VERSION=1.11.33.2

#yum install wget tar make git curl unzip gcc-c++ pcre-devel zlib-devel openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel

mkdir nginx-build-files
cd nginx-build-files

wget http://nginx.org/download/$NGINX_VERSION.tar.gz

# Import GPG/PGP key for Maxim Dounin (nginx dev) to verify download
gpg2 --import << EOT

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.11 (FreeBSD)

mQENBE7SKu8BCADQo6x4ZQfAcPlJMLmL8zBEBUS6GyKMMMDtrTh3Yaq481HB54oR
0cpKL05Ff9upjrIzLD5TJUCzYYM9GQOhguDUP8+ZU9JpSz3yO2TvH7WBbUZ8FADf
hblmmUBLNgOWgLo3W+FYhl3mz1GFS2Fvid6Tfn02L8CBAj7jxbjL1Qj/OA/WmLLc
m6BMTqI7IBlYW2vyIOIHasISGiAwZfp0ucMeXXvTtt14LGa8qXVcFnJTdwbf03AS
ljhYrQnKnpl3VpDAoQt8C68YCwjaNJW59hKqWB+XeIJ9CW98+EOAxLAFszSyGanp
rCqPd0numj9TIddjcRkTA/ZbmCWK+xjpVBGXABEBAAG0IU1heGltIERvdW5pbiA8
bWRvdW5pbkBtZG91bmluLnJ1PokBOAQTAQIAIgUCTtIq7wIbAwYLCQgHAwIGFQgC
CQoLBBYCAwECHgECF4AACgkQUgqZk6HAUvj+iwf/b4FS6zVzJ5T0v1vcQGD4ZzXe
D5xMC4BJW414wVMU15rfX7aCdtoCYBNiApPxEd7SwiyxWRhRA9bikUq87JEgmnyV
0iYbHZvCvc1jOkx4WR7E45t1Mi29KBoPaFXA9X5adZkYcOQLDxa2Z8m6LGXnlF6N
tJkxQ8APrjZsdrbDvo3HxU9muPcq49ydzhgwfLwpUs11LYkwB0An9WRPuv3jporZ
/XgI6RfPMZ5NIx+FRRCjn6DnfHboY9rNF6NzrOReJRBhXCi6I+KkHHEnMoyg8XET
9lVkfHTOl81aIZqrAloX3/00TkYWyM2zO9oYpOg6eUFCX/Lw4MJZsTcT5EKVxIhG
BBARAgAGBQJO01Y/AAoJEOzw6QssFyCDVyQAn3qwTZlcZgyyzWu9Cs8gJ0CXREaS
AJ92QjGLT9DijTcbB+q9OS/nl16Z/IhGBBARAgAGBQJO02JDAAoJEKk3YTmlJMU+
P64AnjCKEXFelSVMtgefJk3+vpyt3QX1AKCH9M3MbTWPeDUL+MpULlfdyfvjj7kB
DQRO0irvAQgA0LjCc8S6oZzjiap2MjRNhRFA5BYjXZRZBdKF2VP74avt2/RELq8G
W0n7JWmKn6vvrXabEGLyfkCngAhTq9tJ/K7LPx/bmlO5+jboO/1inH2BTtLiHjAX
vicXZk3oaZt2Sotx5mMI3yzpFQRVqZXsi0LpUTPJEh3oS8IdYRjslQh1A7P5hfCZ
wtzwb/hKm8upODe/ITUMuXeWfLuQj/uEU6wMzmfMHb+jlYMWtb+v98aJa2FODeKP
mWCXLa7bliXp1SSeBOEfIgEAmjM6QGlDx5sZhr2Ss2xSPRdZ8DqD7oiRVzmstX1Y
oxEzC0yXfaefC7SgM0nMnaTvYEOYJ9CH3wARAQABiQEfBBgBAgAJBQJO0irvAhsM
AAoJEFIKmZOhwFL4844H/jo8icCcS6eOWvnen7lg0FcCo1fIm4wW3tEmkQdchSHE
CJDq7pgTloN65pwB5tBoT47cyYNZA9eTfJVgRc74q5cexKOYrMC3KuAqWbwqXhkV
s0nkWxnOIidTHSXvBZfDFA4Idwte94Thrzf8Pn8UESudTiqrWoCBXk2UyVsl03gJ
blSJAeJGYPPeo+Yj6m63OWe2+/S2VTgmbPS/RObn0Aeg7yuff0n5+ytEt2KL51gO
QE2uIxTCawHr12PsllPkbqPk/PagIttfEJqn9b0CrqPC3HREePb2aMJ/Ctw/76CO
wn0mtXeIXLCTvBmznXfaMKllsqbsy2nCJ2P2uJjOntw=
=Tavt
-----END PGP PUBLIC KEY BLOCK-----

EOT



# GPG signature write to file
wget http://nginx.org/download/$NGINX_VERSION.tar.gz.asc

# Verify signatur to file
gpg2 --verify $NGINX_VERSION.tar.gz.asc $NGINX_VERSION.tar.gz

#TODO: exit 1 if GPG signature fails

tar -xvf $NGINX_VERSION.tar.gz

cd $NGINX_VERSION/src/http/modules/


wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${PAGESPEED_VERSION}-beta.zip -O release-${PAGESPEED_VERSION}-beta.zip

unzip release-${PAGESPEED_VERSION}-beta.zip

cd ngx_pagespeed-release-${PAGESPEED_VERSION}-beta/

wget https://dl.google.com/dl/page-speed/psol/${PAGESPEED_VERSION}.tar.gz

tar -xzvf ${PAGESPEED_VERSION}.tar.gz



# Nginx compile options, based on default compile flags from Nginx 1.10.1 from Nginx repo.
cd ../../../../

./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module --with-http_perl_module=dynamic --with-threads --with-stream --with-stream_ssl_module --with-http_slice_module --with-mail --with-mail_ssl_module --with-file-aio --with-ipv6 --with-http_v2_module --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic' --add-module=src/http/modules/ngx_pagespeed-release-${PAGESPEED_VERSION}-beta

make build
