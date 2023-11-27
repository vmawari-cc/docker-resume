FROM debian:latest as build

RUN apt update && \
	apt install wget -y

RUN wget https://github.com/gohugoio/hugo/releases/download/v0.120.4/hugo_extended_0.120.4_linux-amd64.deb && \
	dpkg -i hugo_extended_0.120.4_linux-amd64.deb

WORKDIR /src

COPY ./ /src

RUN hugo --environment production

FROM nginx:alpine

COPY --from=build /src/public /usr/share/nginx/html

