package persistence.DAO;

import Model.ListaGiochi;
import Model.Profilo;

import java.util.ArrayList;
import java.util.List;

public interface ListaGiochiDAO {
    void save(ListaGiochi listaGiochi); // CREATE
    ArrayList<ListaGiochi> findByPrimaryKey(String email); //RETRIEVE
    ArrayList<ListaGiochi> findAll();
    void update (ListaGiochi listaGiochi); // UPDATE
    void delete(ListaGiochi listaGiochi); //DELETE
}
