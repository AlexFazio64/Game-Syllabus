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
    public boolean save(String idUtente, String idGioco) {
        Connection connection;
        try {
            connection = DBManager.getDataSource().getConnection();
            String queryUpdate = "INSERT INTO listagiochi values(?, ?)";
            PreparedStatement st = connection.prepareStatement(queryUpdate);
            st.setString(1, idUtente);
            st.setString(2, idGioco);
            int value = st.executeUpdate();
            System.out.println(value);
            connection.close();
            return value != 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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
            connection.close();
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

    //INUTILE? mudamudamuda
    @Override
    public boolean update(ListaGiochi listaGiochi) {
        return false;
    }

    //ELIMINA IL COLLEGAMENTO TRA IL GIOCO E L'UTENTE
    @Override
    public boolean delete(String idUtente, String idGioco) {
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String delete = "delete FROM listagiochi WHERE emailutente = ? and idgioco = ? ";
            PreparedStatement statement = connection.prepareStatement(delete);
            statement.setString(1, idUtente);
            statement.setString(2, idGioco);
            int value = statement.executeUpdate();
            connection.close();
            return value != 0;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }
}
