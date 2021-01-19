package persistence.DAO;

import Model.Profilo;

import java.util.List;

public interface ProfiloDAO {

    void save(Profilo profilo); // CREATE
    Profilo findByPrimaryKey(String email); //RETRIEVE
    List<Profilo> findAll();
    void update (Profilo profilo); // UPDATE
    void delete(String emailUtente); //DELETE


}
