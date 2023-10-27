package com.portariaQrCode.login;

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
import com.portariaQrCode.DAO.UsuarioDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Home", loadOnStartup = 5, urlPatterns = {"/home" })
public class PaginaPrincipalServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("home") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/home/home.jsp");
		}
	}

	private void buscarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json,
			String URL) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();

		try {
			dao.conecta();
			Registro param = HttpServices.requestToRegistro(req);
			retorno.put("PARAMETROS", param);
			retorno.put("MENU", menuUsuario(dao, param));
			
			req.setAttribute("dados", HttpServices.parseJSONListStringToHashMap(retorno.toString()));

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(URL);
		    dispatcher.forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}
	}
	
	private List<Registro> menuUsuario(DAO dao, Registro param) {
		List<Registro> ret = new ArrayList<>();
		try {
			ret = new UsuarioDAO(dao).menuUsuario(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

}
