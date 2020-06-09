# Note de clarification - Gestion d'une agence touristique

* Client : Alessandro Victorino
* Objectif : mettre en place une base de donnée et un système de gestion de voyage pour une agence touristique

## Liste des objets qui devront être gérés dans la BDD

* **Ressources humaines** : client, accompagnateur
* **Circuit touristiques** : étapes, activité,transport, hébergement, équipements
* **Factures**
* **Notation**
* **Société** : location d'équipement, hébergement, transport

## Liste des propriétés associées à chaque objet

### Ressource humaine

Une ressource humaine possède un **NSS** (**N**uméro de **S**écurité **S**ocial) qui est unique, un nom, un prénom et une date de naissance.

Une ressource humaine peut-être : 
* Un **Personnel** a un poste, un salaire.
* Un **Client** : qui possède un numéro de téléphone,une adresse, qui peut reserver des circuits, payer des circuits, noter des circuits.
* Un **Acompagnateur** : qui a un poste, un salaire, et qui peut consulter son emploi du temps, un **accompagnateur** est un **Personnel**.

### Circuit touristique

Un circuit touristique possède un type, une date de départ, une durée, un nombre maximun de participants, un prix qui dépend de la période donnée et un niveau de difficulté.

Un client peut laisser un commentaire et/ou une note sur un circuit via une **Notation**.

### Notation

Une notation regroupe une note, un commentaire et un numéro de circuit.


Un circuit touristique est composé de plusieurs **étapes**.

### Étape

Une étape possède une ou plusieurs **activités**, un lieu d'hébergement ainsi qu'un moyen de transport et peut nécessiter la location d'équipements.

Une étape possède un nom, un numéro (ex : étape n°1 du circuit "Découverte de l'Oise"), un lieu (ex : Senlis), une date de début, unê date de fin.



### Activité 

Une activité possède un nom, le nom d'un accompagnateur (si nécessaire) pour cette activité, une heure spécifique de la journée
(ex : "Cheval" à "8h15"). Une activité peut nécessiter la location d'**équipement**.

### Société 

Une société possède un numéro d'identification SIREN, un nom et une réputation. Une société peut-être une société de **Transport**,
une société d'**Hebergement** ou une société de location d'**équipement**.

### Transport

Un moyen de transport possède un type (avion,bus,voiture) et un prix par personne.

### Location

Une location d'équipement à un état d'usure (Neuf, très bon, bon, moyen, inutilisable), un type d'équipement, et un prix.

### Logement 

Un logement possède un type : chambre d'hôte ou hotel et un prix par personne.

### Réservation 

Une réservation peut-être faite par le client et possède une date, un numéro de circuit, un numero de client, elle possède différents status:
réservé, partiellement ou totalement payé.

Une réservation a un prix, calculé en fonction de la période de l'année, un nombre de personne et un état (annulé, validée, en cours)

## Liste des contraintes sur les objets


### Contraintes sur les ressources humaines :

* Un **Client** ne peut pas noter un circuit qu'il n'a pas fait.
* Un **Accompagnateur** ne peut pas participer à une activité qui n'est pas spécifiée dans son emploi du temps.

### Contraintes sur la réservation

* Une réservation est automatiquement fermée si : 
    * le montant n'est pas payé 15 jours avant le début du circuit, dans ce cas là, la réservation est annulée.
    * le paiement à été effectué dans ce cas là, la réservation passe au statut totalement payée.

### Liste des utilisateurs appelés à modifier et consulter les données

* En cas d'annulation d'une réservation, un client doit demander à un employé de l'agence de supprimer sa réservation.
* Les membres du **Personnels** doivent pouvoir :
    * gérer les clients et leur données
    * gérer les circuits, activités et étapes
    * gérer la location et le transport

* Un client peut consulter à tout moment sa facture ainsi que son profil, le circuit, les étapes et les activités
 qu'il va faire.

### Liste des fonctions que ces utilisateurs pourront effectuer

* **Acompagnateur** : consulter son emploi du temps.
* **Personnels** : peut consulter le planning d'un accompagnateur et le modifier, peuvent supprimer des reservations, des clients, des étapes ou des activités pour un Circuit Touristique. Si un circuit n'est pas très fréquenté, ils peuvent aussi supprimer ce circuit.
* **Client** : peut seulement accéder à son profil et ses réservations.

# Choix sur l'héritage

Pour ce projet, il y aura 2 types d'héritages : l'*héritage par classe mère* et l'*héritage par référence*.

## Héritage par la classe mère

Après études des contraintes, l'héritage des classes **Transport**,**Logement** et **Location** par la classe **Societe** se fera par classe mère.

En effet, les classes filles n'ont pas d'attributs permettant de les différenciés entre elles, la différenciation se fait uniquement sur la création de ces classes.
Ainsi, un attribut dans la classe **Société** sera reservé pour désigné si c'est une société de **Transport**, une société de **Logement** (donc un hôtel ou une chambre d'hôte)
ou encore une société de **Location** d'équipement.

## Heritage par référence 

L'héritage des classes **Personnel** et **Client** par la classe mère **RessourceHumaine** se fera par référence, un attribut sera ajouté dans chacune de ces classes pour faire référence
aux tuples de la classe mère **Ressource Humaine**. 

Le choix s'est fait simplement en remarquant que l'héritage par classe mère n'était pas judicieux car les deux classes filles possède beaucoup d'attributs qui différent, et n'ont en réalité, 
pas du tout le même rôle dans l'agence, contrairement aux sociétés qui ont le rôle de *fournir quelque chose* aux circuits touristiques.
De même l'héritage par classe fille n'était pas envisageable car il aurait fallu répéter tous les tuples de **Ressource Humaine** dans **Client** et **Personnel** et on perdrait donc 
le côté *général* de la classe mère abstraite **RessourceHumaine**.
