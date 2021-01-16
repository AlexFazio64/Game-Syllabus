package group64.gamesyllabus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import persistence.DBManager;
import persistence.DBSource;

import java.sql.SQLException;

@SpringBootApplication
public class GameSyllabusApplication {
	
	public static void main(String[] args) {
		DBManager.getInstance();                        //initialize
		try {
			DBManager.getDataSource().getConnection();  //check connection
		} catch (SQLException throwables) {
			throwables.printStackTrace();
			return;                                     //exit if not connected to DB
		}
		
		SpringApplication.run(GameSyllabusApplication.class, args);
	}
	
}
