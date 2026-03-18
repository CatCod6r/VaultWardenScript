# VaultWardenScript
Script and files to automatically install and setup Vaultwarden

# Usage 
Prerequisites:
- Ubuntu(24.04) 
- Docker(with compose plugin installed) 
Add:
- ADMIN_TOKEN(usually generated with echo -n "MySecretPassword" | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4 | sed 's#\$#\$\$#g')
- DOMAIN_NAME
- YOURE_EMAIL(for generating ssl certificates)
