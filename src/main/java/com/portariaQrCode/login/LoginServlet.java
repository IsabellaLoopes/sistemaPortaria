package com.portariaQrCode.login;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Login", loadOnStartup = 5, urlPatterns = {"/login/entrar" })
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("login/entrar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/login/primeiroPassos.jsp");
		}
	}

	private void buscarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json,
			String URL) throws ServletException, IOException {

		JSONObject retorno = new JSONObject();

		// String ret = AQUI VAI O BANCO DE DADOS 

		//JSONObject aux = new JSONObject(ret);
		//String dataRet = aux.getString("DATA");
		retorno.put("PARAMETROS", HttpServices.requestToRegistro(req));
		//retorno.put(Constantes.CODDER, aux.get(Constantes.CODDER));
		//retorno.put(Constantes.MSG, aux.get(Constantes.MSG));
		//retorno.put("DATA", new JSONObject(dataRet != null && !dataRet.isEmpty() ? dataRet.trim() : "{}"));

		//req.setAttribute("usuario", HttpServices.parseJSONListStringToHashMap(usuario));
		req.setAttribute("dados", HttpServices.parseJSONListStringToHashMap(retorno.toString()));

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(URL);
	    dispatcher.forward(req, resp);
		//HttpUtil.dispacher(req, resp, URL);
	}

}
