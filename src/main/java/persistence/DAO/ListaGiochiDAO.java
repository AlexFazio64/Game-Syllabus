package persistence.DAO;

import Model.ListaGiochi;
import Model.Profilo;

import java.util.ArrayList;
import java.util.List;

public interface ListaGiochiDAO {
    boolean save(String idUtente, String idGioco); // CREATE
    ArrayList<ListaGiochi> findByPrimaryKey(String email); //RETRIEVE
    ArrayList<ListaGiochi> findAll();
    boolean update (ListaGiochi listaGiochi); // UPDATE
    boolean delete(String idUtente, String idGioco); //DELETE
}
