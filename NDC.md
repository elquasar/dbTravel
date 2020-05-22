# Note de clarification - Gestion d'une agence touristique

* Client : Alessandro Victorino
* Objectif : mettre en place une base de donnée et un système de gestion de voyage pour une agence touristique

## Liste des objets qui devront être gérés dans la BDD

* **Ressources humaines** : client, accompagnateur
* **Circuit touristiques** : étapes, activité,transport, hébergement, équipements
* **Factures**
* **Notation**

## Liste des propriétés associées à chaque objet

### Ressource humaine

Une ressource humaine possède un **NSS** (**N**uméro de **S**écurité **S**ocial) qui est unique, un nom, un prénom et une date de naissance.

Une ressource humaine peut-être : 

* Un **Client** : qui possède un numéro de téléphone, qui peut reserver des circuits, payer des circuits, noter des circuits.
* Un **Ami**, **Membre de la famille**, qui est rattaché à un client spécifique.
* Un **Acompagnateur** : qui a un poste, un salaire, et qui peut consulter son emploi du temps.

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

### Équipements

Un équipement à un état d'usure (Neuf, très bon, bon, moyen, inutilisable), cet état doit être renseigné par l'utilisateur.
Il possède une référence, un prix de location, une durée de location.

### Facture

Une facture possède un numero unique rattaché à un circuit et un client, un montant, une date d'émission. 
Le montant de la facture est différents en fonction de la période. (ex : prix standard, prix de saison : vacances de noel,paques,été).

### Réservation 

Une réservation peut-être faite par le client et possède une date, un numéro de circuit, un numero de client, elle possède différents status:
réservé, partiellement ou totalement payé, la reservation est close lorsqu'elle est payée, la reservation est annulée lorsque le client
n'a pas payé 15 jours avant le départ.


