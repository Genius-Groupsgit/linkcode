# LienCourt — mini SaaS de démonstration

Raccourcisseur de liens avec compteur de clics et landing page. **Aucune dépendance** : Node seul,
donc rien à installer ni à compiler. Conçu pour être déployé en une minute avec GeniusDeploy.

```bash
npm start          # http://localhost:3000   (PORT=… pour changer)
npm test           # test de bout en bout, sans dépendance
```

## Déploiement (rapide)
- Un `Dockerfile` de 8 lignes (image `node:22-alpine`, aucune dépendance à installer) : le build prend quelques secondes, il n'y a rien à télécharger ni à compiler. Port **3000**.
- Sonde de santé : `GET /` (la landing) et `GET /healthz`.
- Les liens sont gardés dans `data/links.json`, ou en mémoire si le disque est en lecture seule.

## Scénarios de panne pour la démo (l'assistant répare)

| Panne à provoquer | Modification | Ce que fait l'assistant |
|---|---|---|
| Mauvais port | Dans `server.js`, remplacer `Number(process.env.PORT) \|\| 3000` par `8080` | Lit « listening on port 8080 » dans les logs, propose le port 8080, relance. |
| Script de démarrage absent | Renommer `start` en `serve` dans `package.json` | Explique la cause ; la correction du `package.json` demande votre approbation (branche dédiée). |

Faire la panne sur une **branche** (`demo-panne`) et déployer cette branche : `main` reste sain pour le déploiement normal.
