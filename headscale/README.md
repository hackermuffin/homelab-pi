# Headscale

Runs a [headscale](https://headscale.net/) server, which runs a self hosted tailnet, which can be connected to with the [tailscale](https://tailscale.com/) client.

## Headscale config

You'll need to grab an example version of the config file from the headscale repo, then edit it to match your domains and desired config:

```
curl "https://raw.githubusercontent.com/juanfont/headscale/main/config-example.yaml" -o headscale-config.yml
```

## Env file

You'll need an env file with the following variables defined:

- `VOLUME_PATH`: where to store the persistent data for caddy and the control server, `./data/` is what I use
- `TZ`: set the timezone for the containers, to make some logging clearer
- `CADDY_EMAIL`: email to use for caddy to obtain the SSL certificate
- `HEADSCALE_URL`: FQDN for where the caddy server should be served


## Other notes

Headscale doesn't use pure HTTP(S) to establish it's connection - it likes to jump into a different protocol partway thorough. The result is that it doesn't play well with some things like Cloudflare proxying or tunnels. I've only been able to get it working with a raw internet facing port, but there may be other options.
