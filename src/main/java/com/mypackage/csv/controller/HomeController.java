package com.mypackage.csv.controller;
import javax.servlet.http.HttpServlet;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController  extends HttpServlet{

	//private final static Logger logger = Logger.getLogger(HomeController.class);


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView visitHome(){
		//System.out.println("in controller");
		//logger.info("in controller");
		return new ModelAndView("home");

	}


	@RequestMapping(value="/user", method=RequestMethod.GET)
	public ModelAndView userLogin()
	{

		System.out.println("in login controller");

		return new ModelAndView("user");
	}


	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");

		return model;

	}
	
	@RequestMapping(value="/success" ,method=RequestMethod.GET)
	public ModelAndView successpage()
	{
		return new ModelAndView("success");
	}

	
}



