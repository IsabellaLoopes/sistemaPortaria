package com.portariaQrCode.dashboard;

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
import com.portariaQrCode.DAO.DashboardDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;

@WebServlet(description = "Dashboard", loadOnStartup = 5, urlPatterns = {"/dashboard/dashboardCabecalho", 
						"/dashboard/dashboardListarEntrada", "/dashboard/dashboardListarSaida"})
public class DashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("dashboard/dashboardCabecalho") > 0) {
			req.setAttribute("data", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/historico/dashboard/dashboard.jsp", "cabecalho");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getRequestURI().indexOf("dashboard/dashboardListarEntrada") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/historico/dashboard/dashboardListarEntrada.jsp", "listar");
		} else if(req.getRequestURI().indexOf("dashboard/dashboardListarSaida") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/historico/dashboard/dashboardListarSaida.jsp", "listar");
		}
	}
	
	private void buscarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json,
			String URL, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		
		try {
			dao.conecta();
			if(banco.equals("listar")) {
				param.put("data", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
				retorno.put("LISTA", dashboardListar(dao, param));
			} 
			
			retorno.put("PARAMETROS", param);
			req.setAttribute("dados", HttpServices.parseJSONListStringToHashMap(retorno.toString()));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(URL);
		    dispatcher.forward(req, resp);
		}
	}
	
	private List<Registro> dashboardListar(DAO dao, Registro param) {
		List<Registro> ret = new ArrayList<>();
		try {
			ret = new DashboardDAO(dao).listarDash(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
}
