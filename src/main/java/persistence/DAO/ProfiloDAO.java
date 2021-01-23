package persistence.DAO;

import Model.Profilo;

import java.util.List;

public interface ProfiloDAO {
    
    boolean save(Profilo profilo); // CREATE
    Profilo findByPrimaryKey(String email); //RETRIEVE
    Profilo findByUsername(String username); //NEEDED
    List<Profilo> findAll();
    boolean update (Profilo profilo); // UPDATE
    boolean delete(String emailUtente); //DELETE


}
