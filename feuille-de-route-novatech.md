# Feuille de route DevOps — NovaTech (30 / 60 / 90 jours)

**Groupe 07** — Julien, Ulrich, Sofiane, Himane
**Statut** : proposition, non mise en œuvre. Les effets sont attendus, pas mesurés.
**Légende** : ✅ testé par l'équipe · 🧪 simulé / testé partiellement · ⏳ non testé (appuyé sur une source)

> Première version préparée avec l'aide d'une IA, à relire, corriger et compléter par l'équipe (voir `suivi/journal-ia.md`). Les cases « à compléter » attendent la VSM (module 2) et les indicateurs DORA (module 7).

---

## 1. État initial (étape 1)

| Dimension | Constat ou hypothèse | Source |
|---|---|---|
| Culture | Chacun travaille de son côté : les Ops découvrent des changements « la veille », la sécurité arrive « trop tard » | `01_Contexte_et_temoignages.md` |
| Processus | « Les validations et les déploiements prennent parfois plus de temps que le développement » ; part d'attente : à compléter | Témoignage Dev, `novatech/value-stream-map.md` |
| Outils | Des tests existent (« code testé chez nous »), des contrôles de sécurité existent ; retour arrière non accessible lors de l'incident | Témoignages, `novatech/diagnostic.md` |
| Sécurité | On ne sait pas toujours qui valide les exceptions | Témoignage sécurité |
| Fiabilité | Incident du module de paiement : 95 min de restauration (et non de détection) : premier signalement par des utilisateurs à +7 min, réunion Dev/Ops à +20 min, rétablissement 75 min plus tard | `novatech/diagnostic.md` |
| Mesure | Aucune mesure de la performance de livraison connue ; métriques DORA fictives : à compléter | `novatech/indicateurs-dora.md` |
| Contraintes | Expérimentation locale seulement, aucun déploiement client, aucun cloud payant, budget et ROI = hypothèses | `01_Contexte_et_temoignages.md` |

**Hypothèse principale** : les outils existent ; le problème vient surtout du **processus** et de la **collaboration** (tout arrive trop tard, en silos). À vérifier avec les informations manquantes du diagnostic.

---

## 2. Actions par dimension (étapes 2, 3 et 5)

Propriétaires = rôles chez NovaTech. Effort estimé : S (quelques jours), M (2 à 3 semaines), L (plus d'un mois) — hypothèses.

| # | Action | Dimension | Constat d'origine | Propriétaire | Dépend de | Effort | Risque | Métrique | Critère de succès | Preuve |
|---|---|---|---|---|---|---|---|---|---|---|
| C1 | Revue commune des changements à risque (Dev, Ops, sécurité, métier) avant mise en production | Culture | Ops informés la veille | Responsable Ops + lead Dev | — | S | Réunion de plus, perçue comme un frein | Part des changements à risque revus avant production | 100 % des changements à risque du pilote revus | ✅ relecture croisée et pull requests relues dans notre équipe |
| C2 | Revue d'incident sans blâme après chaque incident, avec actions et propriétaires | Culture | Incident du 16 octobre | Responsable Ops | — | S | Glisser vers la recherche de coupable | Actions issues des revues et réalisées | Chaque incident du pilote a sa revue sous 5 jours ouvrés (cible proposée) | 🧪 `experiences/retour-incident.md` (TP 3) |
| P1 | Tableau Kanban partagé Dev / Ops / métier avec limites WIP, sur l'équipe pilote | Processus | Métier sans visibilité | Responsable métier + lead Dev | — | S | Tableau non tenu à jour | Délai médian d'une demande | Délai médian connu et en baisse à J60 | ✅ notre tableau GitHub Projects, limites WIP, goulot « In Review » détecté |
| P2 | Mesurer temps actifs et attentes chaque mois (VSM) | Processus | Attentes longues | Lead Dev | P1 | S | Mesure jugée bureaucratique | Part d'attente du délai total | Part d'attente en baisse à J90 | 🧪 `novatech/value-stream-map.md` (données fictives) |
| P3 | Changements gradués : changements standard pré-autorisés, revue réservée aux changements à risque | Processus | Validations lentes | Responsable des changements (ITSM) | C1, T1 | M | Perte de contrôle perçue | Délai d'approbation | Délai d'approbation réduit sans hausse du taux d'échec | ⏳ ITIL 4 Change Enablement (AXELOS, 2020) ; Accelerate (2018) |
| T1 | Pull request relue + CI (tests) obligatoires sur le code du pilote | Technique | « Testé chez nous », erreurs après déploiement | Lead Dev | — | S | Relecture qui devient un goulot | Taux d'échec des changements | 100 % des changements du pilote passent par PR relue et CI verte | ✅ CI NovaTech, PR #9 et #61, TP 4 (CI rouge puis verte), branches protégées |
| T2 | Documenter la procédure de retour arrière, la rendre accessible, puis l'exercer dans un environnement autorisé | Technique | Retour arrière inaccessible ; 75 min de rétablissement | Responsable Ops | — | M | Exercice mal préparé | Temps de restauration (DORA) | Procédure trouvée et exécutable sans aide lors de l'exercice | ⏳ non testé ; Q5.7 (blue/green, feature flags) |
| T3 | Contrôles de santé après déploiement et alertes | Technique | Erreurs signalées par des utilisateurs (16 h 52), aucune alerte connue | Responsable Ops | T1 | M | Alertes trop bruyantes | Délai entre déploiement et première alerte automatique | Détection automatique avant signalement client | 🧪 endpoint `/health` vérifié (TP 5) |
| T4 | Notifications CI dans le canal de l'équipe (ChatOps) | Technique | Retours tardifs | Lead Dev | T1 | S | Bruit, fuite d'information | Temps entre échec de CI et correction | Notifications utiles, bruit jugé acceptable par l'équipe | ✅ notifications Discord, `experiences/chatops.md` |
| T5 | Environnement de test décrit as code (Docker Compose) | Technique | Environnements préparés à la main (hypothèse) | Responsable Ops | T1 | M | Écart entre test et production | Temps de mise en place d'un environnement | Environnement de test recréé à l'identique par n'importe quel membre | 🧪 TP 5, `infrastructure/README.md` |
| T6 | Mesure hebdomadaire des 5 métriques DORA sur le pilote | Technique / mesure | Pas de mesure | Lead Dev | T1 | S | Métriques détournées (Goodhart) | Disponibilité des métriques | Les 5 métriques publiées chaque semaine, interprétées en équipe | 🧪 calcul sur données fictives (TP 6) |
| S1 | Détection de secrets à chaque pull request | Sécurité | Contrôles trop tardifs | Responsable sécurité | T1 | S | Faux positifs | Secrets détectés avant fusion | Aucun secret fusionné sur la branche principale | ✅ job `secrets` de la CI |
| S2 | Définir qui valide les exceptions de sécurité (tableau des responsabilités) | Sécurité | « Nous ne savons pas qui valide les exceptions » | Responsable sécurité + direction | — | S | Désaccord sur les rôles | Exceptions sans décideur identifié | Toute exception a un décideur nommé | ✅ (analogie) notre règle d'arbitrage des désaccords |
| S3 | Ajouter progressivement d'autres contrôles (dépendances, analyse de code) | Sécurité | Contrôles trop tardifs | Responsable sécurité | S1 | M | Pipeline ralenti | Vulnérabilités détectées avant production | Contrôles ajoutés sans doubler la durée de la CI | ⏳ OWASP Top 10 CI/CD Security Risks |

---

## 3. Priorisation : valeur, effort, risque (Q8.4)

Notation de 1 (faible) à 3 (fort), hypothèses de l'équipe. Priorité = actions à forte valeur, faible effort, faible risque.

| Action | Valeur | Effort | Risque | Décision |
|---|---|---|---|---|
| T1 — PR relue + CI | 3 | 1 | 1 | **30 jours** : déjà testé, répond directement aux erreurs après déploiement |
| T2 — Retour arrière | 3 | 2 | 2 | **30 jours** (documentation), **60 jours** (exercice) : vise les 75 min de rétablissement |
| P3 — Changements gradués | 2 | 2 | 2 | **60 jours** : nécessite C1 et T1 en place |

---

## 4. Projet pilote (Q8.3)

**Proposition** : l'équipe qui maintient le **module de paiement**.
- **Pour** : valeur la plus visible, incident récent, attentes fortes de la direction.
- **Contre** : module critique, donc risque élevé.
- **Garde-fou** : le pilote ne change pas la façon de déployer en production pendant 30 jours ; il ajoute de la relecture, de la CI, de la visibilité et une procédure de retour arrière.
- **Alternative** : commencer par un module moins critique si la direction refuse le risque. À trancher avec la direction.

---

## 5. Répartition 30 / 60 / 90 jours et points de décision (étape 4, Q8.6, Q8.7)

| Période | Actions | Point de décision | Poursuivre si… | Ajuster si… | Arrêter si… |
|---|---|---|---|---|---|
| **J1 à J30** | C1, P1, T1, T4, S1, S2, T2 (documentation), T6 (mesure initiale) | **J30** | PR relues et CI sur 100 % des changements du pilote, procédure de retour arrière écrite et accessible, métriques DORA disponibles | La relecture devient un goulot (comme « In Review » chez nous), notifications trop bruyantes | Taux d'échec des changements en hausse nette sans explication, ou rejet par l'équipe pilote |
| **J31 à J60** | T2 (exercice), T3, C2 en routine, P2, P3 | **J60** | Exercice de retour arrière réussi, délai médian connu et stable ou en baisse | Exercice partiel, approbations encore lentes | Exercice impossible à organiser dans un environnement autorisé |
| **J61 à J90** | T5, S3, extension à une deuxième équipe, livraison continue (pas déploiement continu) sur le pilote | **J90** | Indicateurs du pilote meilleurs qu'à J30, deuxième équipe volontaire | Gains limités à une seule dimension | Aucun indicateur amélioré : revenir au diagnostic |

Les valeurs de départ (délai médian, taux d'échec, temps de restauration) sont à mesurer en début de pilote : nous ne fixons pas de chiffre cible inventé.

---

## 6. Risques et résistances (Q8.5)

| Risque ou résistance | Qui | Traitement proposé |
|---|---|---|
| Peur que plus de livraisons = plus d'incidents | Ops | Commencer par la relecture, la CI et le retour arrière avant d'accélérer ; mesurer le taux d'échec |
| Peur de perdre le contrôle | Sécurité, ITSM | Contrôles automatisés plus tôt (S1), décideurs nommés (S2), revue gardée pour les changements à risque (P3) |
| Impatience | Métier, direction | Visibilité immédiate avec le Kanban (P1), point de décision à J30 |
| Relecture qui devient un goulot | Dev | Limite WIP sur la relecture, règle « finir avant de commencer » (vécu dans notre équipe) |
| Outils sans changement de culture | Tous | Revues sans blâme (C2), rétrospectives, commencer petit (Q8.1) |

---

## 7. Hypothèses budgétaires

- Pas de cloud payant ni de nouvel outil payant : la plateforme Git et la CI existantes suffisent pour le pilote (hypothèse).
- Le coût principal est le **temps des équipes** (revues, exercice de retour arrière, mise en place des mesures) : non chiffré, faute d'effectifs et de budgets fournis.
- Aucun retour sur investissement n'est annoncé : tout gain est une hypothèse à vérifier avec les métriques du pilote.

---

## 8. Limites

- Proposition non mise en œuvre ; effets attendus et non mesurés.
- Données et incident fictifs ; aucune cause racine de l'incident n'est prouvée.
- Expérimentations faites sur notre propre équipe et en local, pas chez NovaTech.
- Valeurs de départ des indicateurs inconnues : à mesurer avant toute comparaison.
