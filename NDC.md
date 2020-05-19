# Note de clarification - Gestion d'une agence touristique

* Client : Alessandro Victorino
* Objectif : mettre en place une base de donnée et un système de gestion de voyage pour une agence touristique

## Liste des objets qui devront être gérés dans la BDD

* **Ressources humaines** : client, accompagnateur
* **Circuit touristiques** : étapes, activité,transport, hébergement, équipements
* **Factures**
* **Notation**

## Liste propriétés associées à chaque objet

### Ressource humaine

Une ressource humaine possède un **NSS** (**N**uméro de **S**écurité **S**ocial) qui est unique, un nom, un prénom et une date de naissance.

Une ressource humaine peut-être : 

* Un **Client** : qui possède un numéro de téléphone
* Un **Acompagnateur** : qui a un poste, un salaire, et qui peut consulter son emploi du temps.

### Circuit touristique

Un circuit touristique possède un type, une date de départ, une durée, un nombre maximun de participants, un prix qui dépend de la période donnée et un niveau de difficulté.

Un client peut laisser un commentaire et/ou une note sur un circuit via une **Notation**.

### Notation

Une notation regroupe une note, un commentaire et un numéro de circuit.

Un circuit touristique est composé de plusieurs **étapes**.

### Étape

Une étape possède une activité, un lieu d'hébergement ainsi qu'un moyen de transport et peut nécessiter la location d'équipements.
