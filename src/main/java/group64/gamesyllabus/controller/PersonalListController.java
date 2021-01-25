package group64.gamesyllabus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import persistence.DAO.JDBC.ListaGiochiDAOPG;
import Model.ListaGiochi;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class PersonalListController {

    @GetMapping("/showlist")
    public String loadList(HttpSession session, Model model){
        ArrayList<ListaGiochi> personalList = new ArrayList<ListaGiochi>();
        personalList =  new ListaGiochiDAOPG().findByPrimaryKey(session.getAttribute("emailLogged").toString());
        model.addAttribute("showlist", personalList);

        return "personalList";
    }

    @GetMapping("/deleteElement")
    public String deleteItem(HttpSession session, Model model, @RequestParam String idGame){
        ListaGiochiDAOPG listaGiochiDAOPG = new ListaGiochiDAOPG();
        boolean state = listaGiochiDAOPG.delete(session.getAttribute("emailLogged").toString(), idGame);
        if(state){
            System.out.println("CI SONO");
            model.addAttribute("stateOperation", state);
        }

        /*DA CAMBIARE*/
        return "redirect:/showlist";
    }
}
