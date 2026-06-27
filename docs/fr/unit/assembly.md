# Assemblage

Cette page décrit l'assemblage physique du boîtier et de l'électronique de l'iDryer Unit.

!!! danger "Attention ! Travaux sur équipements électriques haute tension"
    Avant de commencer, lisez attentivement les mesures de sécurité.

    L'iDryer Unit contient des composants fonctionnant sous tension réseau 110–230 V. Une connexion ou une utilisation incorrecte peut entraîner une électrocution, un incendie ou une défaillance de l'appareil.

!!! danger "Travaux sur tension réseau"
    Tous les travaux de connexion à la tension 110–230 V doivent être effectués avec l'appareil hors tension. Avant la première mise en service, assurez-vous que tous les raccordements sont correctement isolés. Pour plus de détails, consultez la section [Sécurité](safety.md).

!!! warning "Mesures de sécurité générales"
    - Débranchez l'appareil avant tout travail.
    - Ne touchez pas les pièces conductrices à découvert.
    - Vérifiez l'intégrité du câblage avant la mise en marche.
    - N'exploitez pas l'appareil avec un boîtier endommagé ou des fils dénudés.
    - Ne laissez jamais l'appareil en marche sans surveillance.
    - Assurez-vous que tous les éléments métalliques du boîtier sont correctement mis à la terre.
    - Éteignez l'appareil immédiatement si vous détectez une odeur de brûlé, de la fumée ou une chaleur anormale du boîtier.
    - Évitez que l'humidité ou la condensation n'entre en contact avec les composants de l'appareil.
    - Utilisez un disjoncteur ou un relais de surcharge.
    - Tous les raccordements doivent être effectués en respectant l'isolation électrique.
    - Si vous n'avez pas d'expérience avec les équipements électriques, consultez un technicien qualifié.

!!! tip "Avant de commencer"
    Assemblez d'abord le système sur une table sans le monter dans le boîtier et vérifiez le fonctionnement de tous les composants. Les instructions de préparation se trouvent dans la section « Avant l'assemblage ».

---

## Ce qu'il vous faut

- Boîtier imprimé — [CAD : modèles et paramètres d'impression](cad.md)
- Tous les composants de la liste des pièces dans la section « Avant l'assemblage »
- Carte Unit MCU programmée et testée

---

## Assemblage étape par étape

### Étapes 1–4 : Chambre principale

<div class="grid cards" markdown>
- ![1](../../img/001.jpg)
- ![2](../../img/002.jpg)
- ![3](../../img/003.jpg)
- ![4](../../img/004.jpg)
</div>

1. Installez les galets du porte-bobine dans la base du boîtier.
2. Installez l'élément chauffant aux emplacements prévus.
3. Fixez l'élément chauffant avec les entretoises (gauche + droite).
4. Installez le disjoncteur thermique KSD9700 en contact avec l'élément chauffant.

!!! warning "Disjoncteur thermique KSD9700"
    Assurez-vous que le KSD9700 est en contact ferme avec le corps du radiateur. Un mauvais contact réduit la fiabilité de la protection d'urgence.

### Étapes 5–7 : Ventilation et volet

<div class="grid cards" markdown>
- ![5](../../img/005.jpg)
- ![6](../../img/006.jpg)
- ![7](../../img/007.jpg)
</div>

5. Installez le ventilateur dans le boîtier et fixez-le avec des éléments de fixation.
6. Assemblez l'ensemble du volet : connectez la lame et le corps du volet. Le type de volet dépend du servo utilisé (3,7 g ou 9 g).
7. Connectez le servo au volet. **Ne fixez pas encore le volet au boîtier à ce stade** — Les angles du servo sont ajustés après la programmation.

### Étapes 8–10 : Compartiment électronique

<div class="grid cards" markdown>
- ![8](../../img/008.jpg)
- ![9](../../img/009.jpg)
- ![10](../../img/010.jpg)
</div>

8. Fixez la carte de commande dans le compartiment électronique.
9. Installez et connectez le connecteur d'alimentation. Utilisez des cosses USHVI pour les câbles d'alimentation.
10. Posez et fixez les câbles des capteurs dans le conduit à câbles. Installez le couvercle du compartiment électronique.

!!! warning "Installation du thermistor"
    Installez le thermistor au bord de l'élément chauffant, environ au milieu de la hauteur des ailettes du radiateur.

    Les sections dénudées des câbles à la base du thermistor ne doivent pas toucher le corps métallique du radiateur. Si nécessaire, isolez ces zones avec du ruban adhésif Kapton ou placez-les dans un tube Teflon / gaine thermorétractable.

    La température du radiateur peut atteindre 140 °C.

![Installation du thermistor](../../img/thermistor.jpg)

---

## Après l'assemblage

Avant la première mise en service :

- [ ] Vérifiez l'isolation de tous les raccordements.
- [ ] Assurez-vous que les câbles ne sont pas pincés par les couvercles.
- [ ] Assurez-vous que le disjoncteur thermique est en bon contact avec l'élément chauffant.
- [ ] Vérifiez l'intégrité du câblage avec un multimètre.

L'étape suivante consiste à installer le micrologiciel dans la section « Contrôleur ».

---

!!! quote "Remerciements"
    Un immense merci à Igor (@dr_perry_coke) pour son excellent travail, son sens esthétique et les images d'assemblage de l'iDryer Unit qu'il a fournies.
