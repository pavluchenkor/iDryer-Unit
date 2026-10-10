# Résolution des problèmes de connexion d'iDryer Unit

Lors de l'utilisation de **iDryer Unit**, certains problèmes de stabilité de connexion peuvent survenir (coupures, perte de MCU, fonctionnement instable).  
Dans la plupart des cas, cela n'est pas dû au périphérique lui-même, mais à des facteurs externes : vibrations, interférences électromagnétiques ou caractéristiques de charge.

Voici les causes principales et les solutions pour les résoudre.

---

## 1. Vibration du câble USB

!!! warning "Symptômes"
    - Coupures périodiques de la connexion  
    - Le périphérique disparaît du système  
    - La connexion est rétablie au toucher du câble  

!!! info "Cause"
    Les vibrations de l'imprimante ou de la sécheuse peuvent causer des micro-mouvements du connecteur USB, entraînant une perte temporaire de contact.

!!! success "Solution"
    - Fixez fermement le câble USB dans le connecteur  
    - Évitez la tension du câble  
    - Si nécessaire :
        - utilisez un câble avec un ajustement plus serré  
        - fixez le câble avec de la colle thermique / des serre-câbles / un support  

---

## 2. Interférences des câbles d'alimentation

!!! warning "Symptômes"
    - Perte de connexion lors de l'activation du chauffage ou du ventilateur  
    - Redémarrages aléatoires du périphérique  
    - Fonctionnement instable sans raison évidente  

!!! info "Cause"
    Les câbles d'alimentation CA créent des interférences électromagnétiques qui se couplent au câble USB.

!!! success "Solution"
    - Éloignez le câble USB et les câbles d'alimentation autant que possible  
    - Ne les installez pas dans le même chemin de câbles  
    - Évitez le routage parallèle sur de longues distances  
    - Installez un filtre ferrite (cylindre ferrite) sur le câble USB plus près du contrôleur et/ou de la carte imprimante

---

## 3. Interférences du ventilateur

!!! warning "Symptômes"
    - Perte de connexion lors de l'activation/désactivation du ventilateur  
    - Défauts coïncidant avec le fonctionnement du ventilateur du sèche-linge  
    - Instabilité lors du contrôle PWM  

!!! info "Cause"
    Un ventilateur 110–230 V est équipé d'une alimentation à découpage et peut générer des interférences affectant les lignes de signal.

!!! success "Solution"
    Il est recommandé d'installer un **RC-snubber (snubber)** en parallèle avec le ventilateur. Ou utilisez un filtre ferrite sur le câble USB.

---

## 4. Port USB 3.0 – problèmes en fonctionnement

!!! warning "Symptômes"
    - Coupures périodiques de la connexion pendant le fonctionnement  
    - Le périphérique disparaît du système sans raison apparente  
    - Le problème disparaît en basculant vers un autre port  

!!! info "Cause"
    C'est un problème courant avec les périphériques USB fonctionnant en mode Full Speed (USB 2.0) connectés à des ports USB 3.0. Les ordinateurs modernes utilisent des répéteurs eUSB2 dans les ports USB 3.0, qui ne sont pas entièrement compatibles avec la spécification USB 2.0 – ce qui entraîne des erreurs de synchronisation et d'énumération. Le problème a été officiellement confirmé par STMicroelectronics : [FAQ sur le site ST](https://community.st.com/t5/stm32-mcus/faq-possible-communication-failure-between-stlink-v3-and-some/ta-p/736578).

!!! success "Solution"
    - Connectez iDryer Unit **uniquement aux ports USB 2.0** (généralement des connecteurs noirs)  
    - Si tous les ports sont USB 3.0 – utilisez un **concentrateur USB actif avec ports USB 2.0**

---

## 5. Port USB 3.0 – problèmes lors du flashage

!!! warning "Symptômes"
    - Le contrôleur n'est pas reconnu en mode bootloader (BOOTSEL)  
    - Le flashage du micrologiciel échoue ou se bloque  
    - Le périphérique est reconnu, mais l'écriture de l'image échoue  

!!! info "Cause"
    Même problème de compatibilité USB 3.0 / xHCI. Particulièrement pertinent lors du flashage via les ports USB Type-C sur les ordinateurs portables modernes – ils utilisent plus souvent des répéteurs eUSB2 problématiques.

!!! success "Solution"
    - Lors du flashage, connectez le contrôleur **uniquement à un port USB 2.0**  
    - Préférez les ports USB Type-A à l'arrière du PC  
    - Si le problème persiste – utilisez un **concentrateur USB actif avec ports USB 2.0**
