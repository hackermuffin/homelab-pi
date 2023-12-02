FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Set database vendor
ENV KC_DB=mariadb

# Build optimised container
WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

# Create live container
FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Set entrypoint
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
