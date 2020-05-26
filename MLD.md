RessourceHumaine(#NSS : int, nom : string, prenom : string, date_naissance : date)

Personnel(#NSS => RessourceHumaine : int, poste : string, salaire : decimal)
Accompagnateur(#NSS =>RessourceHumaine : int, poste : string, salaire : decimal)

Client(#NSS => RessourceHumaine : int, adresse : string)


Societe(#SIREN : int, nom : string, reputation : {Bonne|Moyenne|Mauvaise})

Transporteur(#SIREN => Societe)
Hebergeur(#SIREN => Societe)
Equipementier(#SIREN => Societe)

transporte(#Societe => Transporteur.SIREN : int, 
           #Etape_id => Etape.id, 
           prix_par_personne : decimal, 
           type : {avion,bus,bateau}
           )

logement (#Societe => Hebergeur.SIREN : int, 
          #Etape_id => Etape.id : int, 
          prix_par_personne : decimal, 
          logement {chambre_hote, hotel}
          )

location (#Societe => Equipementier.SIREN : int,
          #Activite_id => Activite.id : int, 
          type_equipement : string,
          usure  : {Neuf | très bon | bon |moyen | inutilisable},
          prix_equipement : decimal
         ) 


CircuitTouristique(#id : int,
                   type : string, 
                   date_depart : date, 
                   duree : string, 
                   nb_max : int, 
                   difficulte : {1|2|3|4|5}
                   )
                   
Etape(#id : int,nom : string, lieu : string, date_debut : date_fin :date) avec nom,lieu,date_debut NOT NULL
Activite(#id : int, nom : string, lieu : string)

Reservation (#client => client.NSS, #circuit_id => CircuitTouristique.id, status : {reserve| partiellement payé | totalement payé}, date_emission : date, nombre_personne : int)
Notation (#client => client.NSS, #circuit_id : CircuitTouristique.id, note : {1|2|...|10}, commentaire : string)
