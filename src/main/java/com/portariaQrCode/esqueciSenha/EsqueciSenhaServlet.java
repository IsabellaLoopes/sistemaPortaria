package com.portariaQrCode.esqueciSenha;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.portariaQrCode.DAO.DAO;
import com.portariaQrCode.DAO.AparelhoDAO;
import com.portariaQrCode.DAO.UsuarioDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Suporte", loadOnStartup = 5, urlPatterns = {"/esqueciSenha", "/esqueciSenha/validarUsuario",
														"/esqueciSenha/salvarNovaSenha"})
public class EsqueciSenhaServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("esqueciSenha") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/login/esqueciSenha.jsp");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getRequestURI().indexOf("esqueciSenha/validarUsuario") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "validarUsuario");
		} else if(req.getRequestURI().indexOf("esqueciSenha/salvarNovaSenha") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "salvarNovaSenha");
		}
	}
	
	private void buscarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json,
			String URL) throws ServletException, IOException {
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		
		try {	
			retorno.put("PARAMETROS", param);
			req.setAttribute("dados", HttpServices.parseJSONListStringToHashMap(retorno.toString()));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(URL);
		    dispatcher.forward(req, resp);
		}
	}
	
	private void processarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		try {
			dao.conecta();
			
			if(banco.equals("validarUsuario")) {
				retorno.put("DATA", verificarUsuario(dao, param));
			} else if(banco.equals("salvarNovaSenha")) {
				retorno.put("DATA", salvarNovaSenha(dao, param));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}
		
		HttpUtil.flushJSON(resp.getOutputStream(), retorno.toString());
	}
	
	private Registro verificarUsuario(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new UsuarioDAO(dao).verificarUsuarioSenha(param);
			dao.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro salvarNovaSenha(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new UsuarioDAO(dao).salvarNovaSenha(param);
			dao.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
}
