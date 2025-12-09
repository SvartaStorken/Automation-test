FROM registry.access.redhat.com/ubi10/nginx-126:10.0

# 1. Byt till root tillfälligt för att få ändra fil-rättigheter
USER 0

# 2. Kopiera din html-fil till mappen vi nu vet är rätt
COPY index.html /opt/app-root/src/index.html

# 3. VIKTIGT: Ändra ägare och rättigheter!
# Vi ger "gruppen" (root-gruppen som OpenShift-användaren tillhör) rätt att läsa/skriva
RUN chown -R 1001:0 /opt/app-root/src/ && \
    chmod -R g+rwX /opt/app-root/src/

# 4. Byt tillbaka till den säkra standard-användaren
USER 1001

# 5. Starta
CMD /usr/libexec/s2i/run
