package com.portariaQrCode.menu;

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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.portariaQrCode.DAO.DAO;
import com.portariaQrCode.DAO.MenuDAO;
import com.portariaQrCode.DAO.UsuarioDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Usuario", loadOnStartup = 5, urlPatterns = {"/adm/menuCabecalho", "/adm/menuListar",
						"/adm/statusMenu", "/adm/menuPermissao", "/adm/menuSalvarPermissoes"})
public class MenuServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("adm/menuCabecalho") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/adm/menu/menu.jsp", "cabecalho");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getRequestURI().indexOf("adm/statusMenu") > 0){
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "status");
		} else if(req.getRequestURI().indexOf("adm/menuSalvarPermissoes") > 0){
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "salvarPermissao");
		} else if(req.getRequestURI().indexOf("adm/menuListar") > 0){
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/adm/menu/menuListar.jsp", "listar");
		}else if(req.getRequestURI().indexOf("adm/menuPermissao") > 0){
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/adm/menu/menuPermissaoModal.jsp", "userPermisao");
		}
	}
	
	private void buscarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json,
			String URL, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		
		try {
			dao.conecta();
			if(banco.equals("listar")){
				retorno.put("LISTA", menuListar(dao, param));
			} else if(banco.equals("userPermisao")){
				retorno.put("DATA", menuPermissoesUsuario(dao, param));
			} else if(banco.equals("cabecalho")) {
				retorno.put("MENU", menuUsuario(dao, param));
			}
			
			retorno.put("PARAMETROS", param);
			req.setAttribute("dados", HttpServices.parseJSONListStringToHashMap(retorno.toString()));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(URL);
		    dispatcher.forward(req, resp);
			//HttpUtil.dispacher(req, resp, URL);
		}
	}
	
	private void processarDados(HttpServletRequest req, HttpServletResponse resp, String method, String json, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		try {
			dao.conecta();
			if(banco.equals("status")) {
				retorno.put("DATA", menuStatus(dao, param));
			} else if(banco.equals("salvarPermissao")) {
				retorno.put("DATA", menuAtribuirPermissao(dao, param));
			}
			retorno.put("PARAMETROS", param);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}
		
		HttpUtil.flushJSON(resp.getOutputStream(), retorno.toString());
	}
	
	private Registro menuStatus(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new MenuDAO(dao).alteraStatusMenu(param);
			if(ret.getAsInt("erro") == 0) {
				dao.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private List<Registro> menuListar(DAO dao, Registro param) {
		List<Registro> ret = new ArrayList<>();
		try {
			ret = new MenuDAO(dao).listarMenu(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro menuPermissoesUsuario(DAO dao, Registro param){
		Registro ret = new Registro();
		try {
			ret.put("USUARIOS", new UsuarioDAO(dao).listarUsuario(param));
			ret.put("PERMISSOES", new MenuDAO(dao).listarPermissoesMenu(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro menuAtribuirPermissao(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new MenuDAO(dao).atribuirPermissaoMenu(param);
			if(ret.getAsInt("erro") == 0) {
				dao.commit();
			}
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
