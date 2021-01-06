package group64.gamesyllabus;

import org.springframework.web.bind.annotation.*;

@org.springframework.stereotype.Controller
public class Controller {
	@GetMapping("/jsp")
	public String provaJsp(){
		return "prova";
	}
}