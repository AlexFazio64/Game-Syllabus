package persistence.DAO.JDBC;

import Model.Profilo;
import persistence.DAO.ProfiloDAO;
import persistence.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class ProfiloDAOPG implements ProfiloDAO {
    @Override
    public void save(Profilo profilo) {

    }

    @Override
    public Profilo findByPrimaryKey(String email) {
        return null;
    }

    @Override
    public List<Profilo> findAll() {
        Connection connection;
        List<Profilo> profili = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            profili = new ArrayList<>();
            Profilo profilo;
            PreparedStatement statement;
            String query = "select * from profilo";
            statement = connection.prepareStatement(query);
            ResultSet result = statement.executeQuery();
            while (result.next()){
                profilo = new Profilo();
                profilo.setEmail(result.getString("email"));
                profilo.setUsername(result.getString("username"));
                profilo.setPassword(result.getString("password"));
                profilo.setDescrizione(result.getString("descrizione"));
                profili.add(profilo);
            }
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return profili;
    }

    @Override
    public void update(Profilo profilo) {

    }

    @Override
    public void delete(Profilo profilo) {

    }
}
