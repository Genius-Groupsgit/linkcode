# Build quasi instantané : aucune dépendance à installer, on copie le code et on démarre.
FROM node:22-alpine
# curl : la sonde de santé de la plateforme en a besoin (l'image de base n'a que wget).
RUN apk add --no-cache curl
WORKDIR /app
ENV NODE_ENV=production PORT=3000
COPY --chown=node:node . .
RUN mkdir -p data && chown node:node data
USER node
EXPOSE 3000
HEALTHCHECK --interval=15s --timeout=3s --start-period=5s CMD curl -fs http://127.0.0.1:3000/healthz || exit 1
CMD ["node", "server.js"]
