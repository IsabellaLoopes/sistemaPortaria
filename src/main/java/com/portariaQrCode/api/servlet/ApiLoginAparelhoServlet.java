package com.portariaQrCode.api.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.portariaQrCode.DAO.AparelhoDAO;
import com.portariaQrCode.DAO.DAO;
import com.portariaQrCode.DAO.UsuarioDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Login Aparelho API", loadOnStartup = 5, urlPatterns = {"/api/login/aparelho"})
public class ApiLoginAparelhoServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("api/login/aparelho") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "login");
		}
	}

	private void processarDados(HttpServletRequest req, HttpServletResponse resp, String method, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		try {
			dao.conecta();
			if(banco.equals("login")) {
				retorno.put("DATA", login(dao, param)); 
			}
			retorno.put("PARAMETROS", param);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}
		
		resp.setContentType ("text/html;charset=utf-8");
		HttpUtil.flushJSON(resp.getOutputStream(), retorno.toString());
	}
	
	private Registro login(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new AparelhoDAO(dao).loginAparelhoMobile(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
}
