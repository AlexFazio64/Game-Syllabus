package group64.gamesyllabus.controller;

import org.springframework.web.bind.annotation.*;

@org.springframework.stereotype.Controller
public class Controller {
	@GetMapping("/")
	public String index(){
		return "index";
	}
}