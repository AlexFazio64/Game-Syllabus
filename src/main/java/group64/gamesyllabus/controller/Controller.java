package group64.gamesyllabus.controller;

import Model.Profilo;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import persistence.DAO.JDBC.ProfiloDAOPG;

@org.springframework.stereotype.Controller
public class Controller {
	@GetMapping("/")
	public String index(){
		return "index";
	}

	@GetMapping("/chooseUsername")
	public String chooseUsername(){
		return "chooseUsername";
	}


	@GetMapping ("regPage")
	public String registerPage (){
		return "register";
	}

	@GetMapping ("regError")
	public String showRegError(@RequestParam String errorType, Model model){
		model.addAttribute("errorType", errorType);
		return "registerError";
	}

	//Register user
	@PostMapping("/register")
	public String registerUser (@RequestParam String email,@RequestParam String username,@RequestParam String password, Model model) {

		Profilo profilo = new Profilo();
		ProfiloDAOPG profiloDAOPG = new ProfiloDAOPG();
		profilo.setEmail(email);
		profilo.setUsername(username);
		profilo.setPassword(password);

		boolean emailUsata = false;
		boolean usernameUsato = false;

		if (profiloDAOPG.findByPrimaryKey(email) != null )
			emailUsata = true;
		if (profiloDAOPG.findByUsername(username) != null)
			usernameUsato = true;

		if (emailUsata == false && usernameUsato == false) {
			profiloDAOPG.save(profilo);
			return index();
		}
		else if (usernameUsato && emailUsata){
			return showRegError("Username and Email", model);

		}
		else if (usernameUsato){
			return showRegError("Username", model);
		}

		else{
			return showRegError("Email", model);
		}


	}
}