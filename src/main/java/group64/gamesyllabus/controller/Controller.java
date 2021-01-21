package group64.gamesyllabus.controller;

import Model.Profilo;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import persistence.DAO.JDBC.ProfiloDAOPG;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

@org.springframework.stereotype.Controller
public class Controller {
	@GetMapping("/index")
	public String index(){
		return "index";
	}

	@GetMapping("/getNavbar")
	public String navbar (HttpSession session) {
		Boolean error = false;
		session.setAttribute("error", error);
		return "navbar";
	}


	@GetMapping ("regPage")
	public String registerPage (HttpSession session){
		ProfiloDAOPG profiloDAOPG = new ProfiloDAOPG();
		int iscritti = profiloDAOPG.findAll().size();
		session.setAttribute("nIscritti", iscritti);
		return "register";
	}

	@GetMapping ("regError")
	public String showRegError(@RequestParam String errorType, Model model){
		model.addAttribute("errorType", errorType);
		return "registerError";
	}

	//Register user

	@PostMapping("/register")
	public String registerUser (HttpSession session,@RequestParam String email,@RequestParam String username,@RequestParam String password, Model model) {

		if (session.getAttribute("emailGoogle")!=null){
			email = session.getAttribute("emailGoogle").toString();
			password = session.getAttribute("passwordGoogle").toString();
		}

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
			session.setAttribute("email",email);
			session.setAttribute("password", password);
			return "redirect:/doLogin";
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