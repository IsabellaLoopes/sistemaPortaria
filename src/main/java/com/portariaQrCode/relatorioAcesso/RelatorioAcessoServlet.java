package com.portariaQrCode.relatorioAcesso;

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
import com.portariaQrCode.DAO.RelatorioAcessoDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;

@WebServlet(description = "Relatório acesso", loadOnStartup = 5, urlPatterns = {"/historico/relatorioAcessoCabecalho", 
						"/historico/relatorioAcessoListar"})
public class RelatorioAcessoServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("historico/relatorioAcessoCabecalho") > 0) {
			req.setAttribute("data", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/historico/relatorioAcesso/relatorioAcesso.jsp", "cabecalho");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getRequestURI().indexOf("historico/relatorioAcessoListar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/historico/relatorioAcesso/relatorioAcessoListar.jsp", "listar");
		}
	}
	
	private void buscarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json,
			String URL, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		
		try {
			dao.conecta();
			if(banco.equals("cabecalho")) {
				retorno.put("DATA", relatorioAcessoCabecalho(dao, param)); 
			} else if(banco.equals("listar")) {
				retorno.put("LISTA", logListar(dao, param));
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
	
	private Registro relatorioAcessoCabecalho(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret.put("APARELHO", new RelatorioAcessoDAO(dao).listarAparelho(new Registro()));
			ret.put("TIPO", new RelatorioAcessoDAO(dao).listarTipoPessoa(new Registro()));
			ret.put("PESSOA", new RelatorioAcessoDAO(dao).listarPessoa(new Registro()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private List<Registro> logListar(DAO dao, Registro param) {
		 List<Registro> ret = new ArrayList<>();
		try {
			ret = new RelatorioAcessoDAO(dao).listarAcesso(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
}
