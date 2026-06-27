# Avant l'assemblage

Familiarisez-vous avec cette section avant d'acheter les composants. Assurez-vous que toutes les pièces et outils nécessaires sont disponibles.

!!! warning "Sécurité électrique"
    L'appareil fonctionne à une tension secteur de 110–230 V. Avant de commencer, lisez la section [Sécurité](safety.md).

---

## Modèles CAO

Imprimez le boîtier avant de commencer l'assemblage. Modèles et paramètres d'impression : [CAO](cad.md).

Matériau du boîtier : **ABS, ABS-CF, ABS-GF, PC ou HTPLA**. N'utilisez pas PLA ou PETG — ils ne résistent pas à la température de fonctionnement.

---

## Ensemble de composants pour une unité

### Électronique et composants

| Composant | Quantité | Remarque |
|---|---|---|
| Carte iDryer Unit MCU | 1 | Bloc principal ; pour chaque bloc supplémentaire — carte EXT |
| Élément chauffant PTC 110–230 V, 100 W | 1 | |
| Ventilateur | 1 | Pour la circulation de l'air |
| Capteur de température NTC 100 K | 1 | Ou tout autre capteur supporté par Klipper/Standalone |
| Capteur de température et d'humidité SHT3X | 1 | Ou tout capteur I2C supporté par le micrologiciel |
| Disjoncteur thermique KSD9700 (130 °C) | 1 | Ou fusible thermique jetable RH130 |
| Servo pour le volet | 1 | 3,7 g ou 9 g (voir section CAO) |
| Câble de brassage RJ45 | Nombre de blocs EXT | Standard, Cat5e ou supérieur |

### Fixations et connecteurs

| Position | Remarque |
|---|---|
| Connecteurs de terminal | Selon le schéma de la carte |
| Cosses USHVI | Pour sertir les câbles de radiateur |
| Gaine thermorétractable | Pour l'isolation des connexions |

### Logiciel

Avant l'assemblage, décidez du mode de fonctionnement — cela détermine le micrologiciel :

- **Klipper** — nécessite une imprimante avec Klipper installé.
- **Standalone** — fonctionne sans imprimante, contrôle via écran et/ou portail.

Pour plus d'informations sur le choix, consultez la section « À propos du projet ».

---

## Outils

- Outil de sertissage (outil de sertissage RJ45)
- Pince à sertir pour cosses USHVI
- Fer à souder (si nécessaire)
- Multimètre pour vérifier les connexions
- Tournevis et clés aux tailles requises

---

## Recommandation

Assemblez le système **sur une table sans le monter dans le boîtier** et effectuez des tests initiaux :

1. Connectez l'élément chauffant, le ventilateur, les capteurs et le servo à la carte.
2. Chargez le micrologiciel et vérifiez que chaque composant fonctionne correctement.
3. Ce n'est qu'après un test réussi que vous devez monter les composants dans le boîtier.

Lors du montage final, raccourcissez les câbles des capteurs et d'alimentation à la longueur minimale nécessaire.