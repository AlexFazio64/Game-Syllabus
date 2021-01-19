package persistence.DAO.JDBC;

import Model.ListaGiochi;
import Model.Profilo;
import persistence.DAO.ListaGiochiDAO;
import persistence.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ListaGiochiDAOPG implements ListaGiochiDAO {
    //AGGIUNGE UN COLLEGAMENTO TRA EMAIL E GIOCO PER LA LISTA
    @Override
    public void save(ListaGiochi listaGiochi) {
        Connection connection;
        try {
            connection = DBManager.getDataSource().getConnection();
            String queryUpdate = "INSERT INTO listagiochi values(?, ?)";
            PreparedStatement st = connection.prepareStatement(queryUpdate);
            st.setString(1, listaGiochi.getEmailUtente());
            st.setString(2, listaGiochi.getIdGioco());
            st.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    //TORNA LA LISTA DI GIOCHI DI QUELL'INDIRIZZO EMAIL
    public ArrayList <ListaGiochi> findByPrimaryKey(String emailUtente) {
        ArrayList <ListaGiochi> listaGiochi = null;
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            listaGiochi = new ArrayList<>();
            String query = "select * from listagiochi where emailutente=?;";
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, emailUtente);
            ResultSet result = st.executeQuery();
            while (result.next()){
                ListaGiochi listaGiochiFind = new ListaGiochi();
                listaGiochiFind.setEmailUtente(result.getString("emailutente"));
                listaGiochiFind.setIdGioco(result.getString("idGioco"));
                listaGiochi.add(listaGiochiFind);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return listaGiochi;
    }

    @Override
    //TORNA LA LISTA DI TUTTI I GIOCHI E INDIRIZZI EMAIL ESISTENTI
    public ArrayList<ListaGiochi> findAll() {
        Connection connection;
        ArrayList<ListaGiochi> listaGiochi = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            listaGiochi = new ArrayList<>();
            ListaGiochi listGame;
            PreparedStatement statement;
            String query = "select * from listagiochi";
            statement = connection.prepareStatement(query);
            ResultSet result = statement.executeQuery();
            while (result.next()){
                listGame = new ListaGiochi();
                listGame.setEmailUtente(result.getString("emailUtente"));
                listGame.setIdGioco(result.getString("idGioco"));
                listaGiochi.add(listGame);
            }
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return listaGiochi;
    }

    //INUTILE?
    @Override
    public void update(ListaGiochi listaGiochi) {

    }

    @Override
    public void delete(ListaGiochi listaGiochi) {
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String delete = "delete FROM listagiochi WHERE emailutente = ? and idgioco = ? ";
            PreparedStatement statement = connection.prepareStatement(delete);
            statement.setString(1, listaGiochi.getEmailUtente());
            statement.setString(2, listaGiochi.getIdGioco());
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
