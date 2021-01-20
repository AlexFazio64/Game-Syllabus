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
    public boolean save(Profilo profilo) {
        Connection connection;
        try {
            connection = DBManager.getDataSource().getConnection();
            String queryUpdate = "INSERT INTO profilo(email, password, username) values(?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(queryUpdate);
            st.setString(1, profilo.getEmail());
            st.setString(2, profilo.getPassword());
            st.setString(3, profilo.getUsername());
            st.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Profilo findByPrimaryKey(String email) {
        Profilo profilo = null;
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String query = "select * from profilo where email=?";
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, email);
            ResultSet result = st.executeQuery();
            if (result.next()){
                Profilo profilo1 = new Profilo();
                profilo1.setEmail(result.getString("email"));
                profilo1.setUsername(result.getString("username"));
                profilo1.setPassword(result.getString("password"));
                profilo1.setDescrizione(result.getString("descrizione"));

                profilo = profilo1;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return profilo;
    }

    @Override
    public Profilo findByUsername(String username) {
        Profilo profilo = null;
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String query = "select * from profilo where username=?";
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, username);
            ResultSet result = st.executeQuery();
            if (result.next()){
                Profilo profilo1 = new Profilo();
                profilo1.setEmail(result.getString("email"));
                profilo1.setUsername(result.getString("username"));
                profilo1.setPassword(result.getString("password"));
                profilo1.setDescrizione(result.getString("descrizione"));

                profilo = profilo1;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return profilo;
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
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String update = "UPDATE profilo SET password = ?, username = ?, descrizione = ? WHERE email = ?";
            PreparedStatement st = connection.prepareStatement(update);
            st.setString(1, profilo.getPassword());
            st.setString(2, profilo.getUsername());
            st.setString(3, profilo.getDescrizione());
            /*st.setBytes(4, profilo.getImmagine());*/
            st.setString(4, profilo.getEmail());

            st.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e.getMessage());
            }
        }

    }

    @Override
    public void delete(String emailUtente) {
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String delete = "delete FROM profilo WHERE email = ?";
            PreparedStatement statement = connection.prepareStatement(delete);
            statement.setString(1, emailUtente);
            statement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }
}
