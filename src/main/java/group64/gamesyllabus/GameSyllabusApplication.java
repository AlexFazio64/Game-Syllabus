package group64.gamesyllabus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import persistence.DBManager;

import java.sql.SQLException;

@SpringBootApplication
public class GameSyllabusApplication {
	
	public static void main(String[] args) {

		/*DBManager.getInstance();

		try {
			DBManager.getDataSource().getConnection();
		} catch (SQLException throwables) {
			throwables.printStackTrace();
			return;
		}*/

		SpringApplication.run(GameSyllabusApplication.class, args);
	}
	
}
