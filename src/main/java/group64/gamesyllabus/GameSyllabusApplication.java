package group64.gamesyllabus;

import Model.ListaGiochi;
import Model.Profilo;
import Model.Recensione;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCrypt;
import persistence.DAO.JDBC.ListaGiochiDAOPG;
import persistence.DAO.JDBC.ProfiloDAOPG;
import persistence.DAO.JDBC.RecensioneDAOPG;
import persistence.DAO.RecensioneDAO;
import persistence.DBManager;

import java.sql.Connection;
import java.util.ArrayList;

@SpringBootApplication
public class GameSyllabusApplication {

    public static void main(String[] args) {
        SpringApplication.run(GameSyllabusApplication.class, args);

    }

}
