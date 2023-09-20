package com.portariaQrCode.util;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HttpUtil {

	public static void dispacher(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		System.out.println(req.getServletContext());
		RequestDispatcher dispatcher = req.getServletContext().getRequestDispatcher(url);
	    dispatcher.forward(req, resp);
	}
}
