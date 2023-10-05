package com.portariaQrCode.util;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

public class HttpUtil {

	public static void dispacher(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		System.out.println(req.getServletContext());
		RequestDispatcher dispatcher = req.getServletContext().getRequestDispatcher(url);
	    dispatcher.forward(req, resp);
	}
	
	public static void flushJSON( ServletOutputStream out, String ret ) {
		try {
			JSONObject jsonObject = new JSONObject(ret);
			String jsonValue = jsonObject.toString();
			out.write(jsonValue.getBytes());
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
