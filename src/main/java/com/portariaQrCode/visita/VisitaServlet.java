package com.portariaQrCode.visita;

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
import com.portariaQrCode.DAO.PermissaoDAO;
import com.portariaQrCode.DAO.UsuarioDAO;
import com.portariaQrCode.DAO.VisitaDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Visita", loadOnStartup = 5, urlPatterns = {"/cadastro/visitaCabecalho", 
						"/cadastro/visitaIncluir", "/cadastro/visitaSalvar", "/cadastro/visitaListar",
						"/cadastro/visitaSaidaManual"})
public class VisitaServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("cadastro/visitaCabecalho") > 0) {
			req.setAttribute("data", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/cadastro/visita/visita.jsp", "cabecalho");
		} else if(req.getRequestURI().indexOf("cadastro/visitaIncluir") > 0) {
			req.setAttribute("data", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			req.setAttribute("dataHora", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));			
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/cadastro/visita/visitaIncluir.jsp", "incluir");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getRequestURI().indexOf("cadastro/visitaSalvar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "salvar");
		} else if(req.getRequestURI().indexOf("cadastro/visitaListar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/cadastro/visita/visitaListar.jsp", "listar");
		} else if(req.getRequestURI().indexOf("cadastro/visitaSaidaManual") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "saidaManual");
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
				retorno.put("DATA", visitaCabecalho(dao, param));
				retorno.put("MENU", menuUsuario(dao, param));
			} else if(banco.equals("listar")) {
				retorno.put("LISTA", visitaListar(dao, param));
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
	
	private void processarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		try {
			dao.conecta();
			if(banco.equals("salvar")) {
				retorno.put("DATA", visitaSalvar(dao, param)); 
			} else if(banco.equals("saidaManual")) {
				retorno.put("DATA", visitaSaidaManual(dao, param)); 
			}
			retorno.put("PARAMETROS", param);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}
		
		HttpUtil.flushJSON(resp.getOutputStream(), retorno.toString());
	}
	
	private Registro visitaCabecalho(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret.put("TIPO", new VisitaDAO(dao).listarTipoPessoa(new Registro()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro visitaSalvar(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new VisitaDAO(dao).salvarVisita(param);
			if(ret.getAsInt("erro") == 0) {
				dao.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro visitaSaidaManual(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new VisitaDAO(dao).salvarSaidaManual(param);
			if(ret.getAsInt("erro") == 0) {
				dao.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	private List<Registro> visitaListar(DAO dao, Registro param) {
		 List<Registro> ret = new ArrayList<>();
		try {
			ret = new VisitaDAO(dao).listarVisita(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
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
