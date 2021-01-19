package group64.gamesyllabus;

import Model.ListaGiochi;
import Model.Profilo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import persistence.DAO.JDBC.ListaGiochiDAOPG;
import persistence.DAO.JDBC.ProfiloDAOPG;


@SpringBootApplication
public class GameSyllabusApplication {

    public static void main(String[] args) {
        SpringApplication.run(GameSyllabusApplication.class, args);
        /*
        PER CREARE UN PROFILO:
        1- CREARE UN OGGETTO PROFILO
        2- IMPOSTARE I CAMPI USERNAME PASSWORD ED EMAIL ( GLI ALTRI SARANNO UPDATE )
        3- CREARE UN OGGETTO ProfiloDAOPG e chiamare la funzione save() passando come campo il profilo creato
        4- il profilo è creato
         */

        /*
        Per creare una correlazione tra un profilo ed un gioco è un concetto simile a quello sopra
        ma questa volta per favore vediti il DAOPG che capisci bene penso dai
         */


    }

}
