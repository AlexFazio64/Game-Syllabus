# IN CASO DI PROBLEMI CON IL VOLUME DOCKER


# Configurazione Docker + postgres
sostituisci < cartella > col percorso della cartella

docker run --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v '< cartella >:/var/lib/postgresql/data' postgres
nuovo server -> group64
nuovo db -> game-syllabus
esegui nuova query
PASSWORD POSTGRES: postgres
PORTA: 5432 PASSWORD PGADMIN: root
NOME SERVER: group64
HOSTNAME: localhost
USERNAME: postgres
PASSWORD SERVER: postgres

Dopo aver creato ciò, utilizzare il seguente codice per riempire il DB con le tabelle e le colonne necessarie: https://github.com/TheDD97/progettoWcomp-Ingsw/blob/doc/DB/game-syllabus_refresh.sql 

# Riempimento

Dopo aver creato tutto il DB, abbiamo preparato un insieme di profili,recensoni e giochi in una lista. Eseguire le seguenti QUERY in ordine
  1- https://github.com/TheDD97/progettoWcomp-Ingsw/blob/doc/DB/profili.txt
  2- https://github.com/TheDD97/progettoWcomp-Ingsw/blob/doc/DB/liste.txt
  3- https://github.com/TheDD97/progettoWcomp-Ingsw/blob/doc/DB/liste.txt
  
Dopo questo, il database dovrebbe essere completamente funzionante.
