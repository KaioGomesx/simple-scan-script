#!/bin/bash

info(){
  echo "[INFO] - $1" | notify -silent
}

warning() {
  echo "[WARNING] - $1" | notify -silent
}

domain=$1

info "Start scan of domain $domain"

host -t txt $domain | grep -o '~all' > /dev/null && info "Email spoofing using $domain domain"

subfinder -d "$domain" -silent | httpx -silent | nuclei -c 50 -l sites -t cnvd/ -t cves/ -t default-logins/ -t exposed-panels -t exposures/apis/ -t exposures/backups/ -t exposures/configs/ -t headless/prototype-pollution-check.yaml -t headless/window-name-domxss.yaml -t miscellaneous/phpmyadmin-setup.yaml -t misconfiguration/ -t network/ -t takeovers/ -t vulnerabilities/ -silent | notify -silent

info "Finished scan of domain $domain"
