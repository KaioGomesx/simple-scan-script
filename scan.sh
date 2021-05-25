#!/bin/bash

info(){
  echo "[INFO] - $1" | notify -silent
}

warning() {
  echo "[WARNING] - $1" | notify -silent
}

domain=$1

info "Start scan of domain $domain"

subfinder -d "$domain" -silent | httpx -silent | nuclei -c 50 -t vulnerabilities -t cves -t exposures -t takeovers -t misconfiguration -t default-logins -silent | notify -silent

info "Finished scan of domain $domain"
