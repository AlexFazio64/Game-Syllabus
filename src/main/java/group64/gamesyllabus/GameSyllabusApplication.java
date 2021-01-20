package group64.gamesyllabus;

import Model.ListaGiochi;
import Model.Profilo;
import Model.Recensione;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import persistence.DAO.JDBC.ListaGiochiDAOPG;
import persistence.DAO.JDBC.ProfiloDAOPG;
import persistence.DAO.JDBC.RecensioneDAOPG;


@SpringBootApplication
public class GameSyllabusApplication {

    public static void main(String[] args) {
        SpringApplication.run(GameSyllabusApplication.class, args);
/*
        Profilo gatsu = new Profilo();
        gatsu.setEmail("Sispib1@gmail.com");
        gatsu.setPassword("0968789031");
        gatsu.setUsername("ArmorOfBerserk");
        ProfiloDAOPG profiloDAOPG = new ProfiloDAOPG();
        profiloDAOPG.save(gatsu);*/

        Recensione recensione = new Recensione();
        recensione.setId(3333);
        recensione.setValutazione(4);
        recensione.setTesto("CAMBIATA");
        recensione.setIdGioco("prova");
        recensione.setScrittoDa("Sispib1@gmail.com");
        RecensioneDAOPG recensioneDAOPG = new RecensioneDAOPG();
        recensioneDAOPG.update(recensione);

/*        RecensioneDAOPG recensioneDAOPG = new RecensioneDAOPG();
        recensioneDAOPG.delete(recensione);*/





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
