## Sécurité

Le micrologiciel du contrôleur — Klipper ou Standalone — offre une protection logicielle :

- surveillance de la température à l'aide de thermistances ;
- vérification de la présence de capteurs de température connectés ;
- protection contre les valeurs de température en dehors des limites de sécurité ;
- utilisation de minuteurs en cas de blocage du système ;
- arrêt automatique en cas d'erreur du capteur ou du contrôleur.

De plus, une protection matérielle est implémentée :

Un disjoncteur thermique KSD9700 (130 °C) est installé, qui coupe physiquement l'alimentation de l'élément chauffant en cas de surchauffe. Ceci est crucial en cas de défaillance logicielle ou matérielle.

Le contrôleur est équipé d'un fusible 2 A qui protège l'appareil. En cas de défaillance, il se grille, coupant complètement l'alimentation du système.

Un élément chauffant PTC avec isolation électrique complète est utilisé. Contrairement à la plupart des solutions de chauffage, le boîtier du radiateur PTC n'est pas sous tension, éliminant le risque d'électrocution lors de l'installation et de la maintenance de la chambre de l'imprimante 3D.

Un tel système de protection à plusieurs niveaux rend l'iDryer Unit une solution sûre pour le séchage du filament, y compris lors d'une opération continue prolongée.

!!! warning "Installation de la thermistance"
    Assurez-vous que les sections de câble dénudées à la base de la thermistance ne touchent pas le boîtier métallique du radiateur. Si nécessaire, isolez ces zones avec du ruban adhésif Kapton ou placez-les dans un tube Teflon / gaine thermorétractable.

    N'oubliez pas que la température du radiateur peut atteindre 140 °C.

!!! danger "KSD9700 — pas de protection finale"
    KSD9700 (disjoncteur thermique) est un appareil auto-récupérable : en cas de surchauffe, il ouvre le circuit, mais dès que la température tombe en dessous du seuil, il se ferme automatiquement. En cas de défaillance du radiateur, l'appareil se surchauffera et refroidira cycliquement sans intervention. Ce n'est pas un arrêt d'urgence — c'est une boucle infinie de surchauffe.

    Pour une exploitation continue, remplacez KSD9700 par un fusible thermique à usage unique (par exemple **RH130**). Il coupe le circuit de façon permanente lors du déclenchement — l'appareil s'éteint et reste dans un état sûr jusqu'au remplacement.

!!! note "Ordre recommandé"
    Utilisez KSD9700 pendant l'assemblage et le débogage. Après vérification du fonctionnement, remplacez-le par un fusible thermique.
