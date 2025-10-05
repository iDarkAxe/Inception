FROM nginx:1.15.3-alpine@sha256:829a63ad2b1389e393e5decf5df25860347d09643c335d1dc3d91d25326d3067

LABEL version="1.0"
LABEL description="This text illustrates \
that label-values can span multiple lines."

# L’instruction EXPOSE informe le moteur de conteneur que le conteneur écoute sur les ports réseau spécifiés au moment de l’exécution.
# EXPOSE <port> [<port>/<protocol>...]

# ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

# L’instruction HEALTHCHECK permet de définir une commande qui sera exécutée périodiquement pour vérifier si le conteneur est en bonne santé. Si la commande échoue, le conteneur sera marqué comme “non sain”. Cela peut être utile pour surveiller l’état de l’application à l’intérieur du conteneur et prendre des mesures si nécessaire.
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1