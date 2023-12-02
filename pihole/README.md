# Pihole

Sets up a [Pihole](https://pi-hole.net/) server with Cloudflare [DNS over HTTPS](https://developers.cloudflare.com/1.1.1.1/encryption/dns-over-https/dns-over-https-client/) through the cloudflared client.

The server is set up to connected to and only accessible through a tailscale network, setting up a dedicated node for pihole to be accessible on.

## Env file

- `VOLUME_PATH`: where to store the persistent data for tailscale. Pihole persistent data (and therefore any GUI changes) are not preserved.
- `TZ`: set the timezone for the containers, to make some logging clearer
- `PIHOLE_PASSWORD`: password for logging into the pihole web interface
- `TAILSCALE_SERVER`: address of the headscale/tailscale server to connect to, including https
- `TAILSCALE_AUTHKEY`: authorisation key genereated from headscale/tailscale server
- `TAILSCALE_HOSTNAME`: the hostname to present to the tailscale network, probably pihole is a good option


