# Keycloak

Docker config to get a [keycloak](https://www.keycloak.org/) identity server up and running.

This config is set up to serve the identity endpoint to a [Cloudflare Tunnel](https://www.cloudflare.com/products/tunnel/), and the admin endpoint to the over a tailscale network. If you want to get this up and running as your tailscale identity provider, you'll probably want this temporary serving to the local network.

## Cloudflare tunnel config

I set up the tunnel with an arbitrary name, with a single public route configured that sends my public identity domain to `https://caddy`, and with the Origin Server Name under TLS settings set also to the public domain to ensure caddy knows what to serve.

In order to get the SSL certificates all established, on first start of the docker containers, I find that the tunnel needs to be set to `http://caddy` as the service, then can be set back to `https://caddy` once caddy has started up. More info in notes.

## Env file

You'll need an env file with the following configured:

- `TZ`: set the timezone for the containers, to make some logging clearer
- `VOLUME_PATH`: where to store the persistent data for caddy and the control server, `./data/` is what I use
- `EMAIL`: the email used to obtain the SSL certificate for the public facing domain
- `CLOUDFLARED_ACCESS_TOKEN`: access token for the cloudflare tunnel as configured above
- `IDENTITY_DOMAIN`: the domain to serve the public identity provider on, which should match the one configured in the cloudflare tunnel
- `KC_HOSTNAME_ADMIN_URL`: the url for accessing the admin portal of keycloak, which should probably be something only locally accessible. See notes for more detail.
- `KEYCLOAK_ADMIN`: admin username for the user keycloak sets up.
- `KEYCLOAK_ADMIN_PASSWORD`: password for the admin user. Only needs to be present in the config on first launch, and should probably be removed after that.
- `MARIADB_USER`: username for the mariadb database user keycloak uses
- `MARIADB_PASSWORD`: password for the mariadb user

## Other notes

The config I run is with Caddy obtaining it's own SSL certificate over the Cloudflare tunnel. Don't have a good explanation for why as the connection between cloudflare and the docker network should already be encrypted, but more ssl more good right...? However, it leads to the odd catch 22 that caddy needs to obtain an SSL certificate to start properly, and needs to start to be able to obtain a certificate through a cloudflare tunnel. 

On admin urls, in theory this would probably be best set to something like `https://192.168.1.52` - the servers local IP address. However, caddy doesn't seem to like serving SSL over IP addresses. In theory seems like this should be fixed (see [layered github flamewar](https://github.com/caddyserver/caddy/issues/2356), but that didn't translate into it working on my end. Currently, I use `https://keycloak.local` and set up local DNS records, and rely on the fact that the port is only accessible on my network.


