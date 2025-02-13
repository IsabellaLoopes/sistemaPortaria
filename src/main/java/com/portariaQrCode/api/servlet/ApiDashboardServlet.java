package com.portariaQrCode.api.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.portariaQrCode.DAO.DAO;
import com.portariaQrCode.DAO.DashboardDAO;
import com.portariaQrCode.DAO.RelatorioAcessoDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Dashboard API", loadOnStartup = 5, urlPatterns = {"/api/dashboard/listar"})
public class ApiDashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getRequestURI().indexOf("api/dashboard/listar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "listar");
		} 
	}
	
	private void processarDados(HttpServletRequest req, HttpServletResponse resp, String method, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		try {
			dao.conecta();
			if(banco.equals("listar")) {
				retorno.put("DATA", dashboardListar(dao, param)); 
			}
			retorno.put("PARAMETROS", param);
			System.out.println(param);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}
		
		resp.setContentType ("text/html;charset=utf-8");
		HttpUtil.flushJSON(resp.getOutputStream(), retorno.toString());
	}
	
	private List<Registro> dashboardListar(DAO dao, Registro param) {
		List<Registro> ret = new ArrayList<>();
		try {
			ret = new RelatorioAcessoDAO(dao).listarAcesso(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
}
