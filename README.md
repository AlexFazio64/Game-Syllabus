# Configurazione Docker + postgres
sostituisci < cartella > col percorso vero, preferibilmente fuori dal git  
  
1. `docker run --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v '< cartella >:/var/lib/postgresql/data' postgres`  
2. nuovo server -> group64  
3. nuovo db -> game-syllabus  
4. esegui nuova query  

PASSWORD POSTGRES: postgres  
PORTA: 5432 
PASSWORD PGADMIN: root  
NOME SERVER: group64  
HOSTNAME: localhost  
USERNAME: postgres  
PASSWORD SERVER: postgres  

# Query creazione db
[Query](https://github.com/TheDD97/progettoWcomp-Ingsw/blob/doc/DB/game-syllabus_refresh.sql)
