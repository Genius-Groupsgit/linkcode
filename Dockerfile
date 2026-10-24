# Déploiement le plus court possible : aucune dépendance à installer, et les couches lentes (curl) passent AVANT le code,
# donc elles restent en cache à chaque nouveau déploiement : seule la copie des 2 fichiers du code est refaite.
FROM node:22-alpine
# curl : la sonde de santé de la plateforme en a besoin (l'image de base n'a que wget).
RUN apk add --no-cache curl && mkdir -p /app/data && chown -R node:node /app
WORKDIR /app
ENV NODE_ENV=production PORT=3000
COPY --chown=node:node package.json server.js ./
COPY --chown=node:node public ./public
USER node
EXPOSE 3000
HEALTHCHECK --interval=3s --timeout=2s --start-period=1s --retries=5 CMD curl -fs http://127.0.0.1:3000/healthz || exit 1
CMD ["node", "server.js"]
