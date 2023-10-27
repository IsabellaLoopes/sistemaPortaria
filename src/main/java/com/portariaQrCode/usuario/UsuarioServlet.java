package com.portariaQrCode.usuario;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.portariaQrCode.DAO.UsuarioDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Usuario", loadOnStartup = 5, urlPatterns = {"/adm/usuarioCabecalho", 
						"/adm/usuarioIncluir", "/adm/usuarioSalvar", "/adm/usuarioListar", "/adm/statusUsuario",
						"/adm/usuarioEditar", "/adm/login", "/adm/verificarPessoa"})
public class UsuarioServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("adm/usuarioCabecalho") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/adm/usuario/usuario.jsp", "cabecalho");
		} else if(req.getRequestURI().indexOf("adm/usuarioIncluir") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/adm/usuario/usuarioIncluir.jsp", "incluir");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getRequestURI().indexOf("adm/usuarioSalvar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "salvar");
		} else if(req.getRequestURI().indexOf("adm/statusUsuario") > 0){
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "status");
		}else if(req.getRequestURI().indexOf("adm/usuarioListar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/adm/usuario/usuarioListar.jsp", "listar");
		}else if(req.getRequestURI().indexOf("adm/usuarioEditar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_POST, "", "/WEB-INF/jsp/adm/usuario/usuarioEditar.jsp", "listarPorId");
		} else if(req.getRequestURI().indexOf("adm/login") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "login");
		} else if(req.getRequestURI().indexOf("adm/verificarPessoa") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "verificarPessoa");
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
				retorno.put("DATA", usuarioCabecalho(dao, param)); 
				retorno.put("MENU", menuUsuario(dao, param));
			} else if(banco.equals("incluir")) {
				retorno.put("DATA", usuarioIncluir(dao, param)); 
			} else if(banco.equals("listar")) {
				retorno.put("LISTA", usuarioListar(dao, param));
			} else if(banco.equals("listarPorId")) {
				retorno.put("DATA", listarPorId(dao, param));
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
			
			if(banco.equals("salvar")) {
				retorno.put("DATA", usuarioSalvar(dao, param)); 
			} else if(banco.equals("status")) {
				retorno.put("DATA", usuarioStatus(dao, param));
			} else if(banco.equals("login")) {
				retorno.put("DATA", verificarLoginWeb(dao, param));
			}else if(banco.equals("verificarPessoa")) {
				retorno.put("DATA", verificarPessoa(dao, param));
			}
			
			if(!banco.equals("login")){
				retorno.put("PARAMETROS", param);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}
		
		HttpUtil.flushJSON(resp.getOutputStream(), retorno.toString());
	}
	
	private Registro usuarioCabecalho(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret.put("LISTA", new UsuarioDAO(dao).listarTipoPessoa(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro usuarioIncluir(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret.put("LISTA", new UsuarioDAO(dao).listarTipoPessoa(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro usuarioSalvar(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			Calendar cal = Calendar.getInstance();
			if(param.getAsIntOrZero("id") <= 0) {
				param.put("senha", "!" + cal.get(Calendar.YEAR) + "Ac3ss0" + cal.get(Calendar.DAY_OF_MONTH
						) + "@" + (cal.get(Calendar.MONTH)+1));
			}
			ret = new UsuarioDAO(dao).salvarUsuario(param);
			if(ret.getAsInt("erro") == 0) {
				dao.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro usuarioStatus(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new UsuarioDAO(dao).alteraStatusUsuario(param);
			if(ret.getAsInt("erro") == 0) {
				dao.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private List<Registro> usuarioListar(DAO dao, Registro param) {
		 List<Registro> ret = new ArrayList<>();
		try {
			ret = new UsuarioDAO(dao).listarUsuario(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro listarPorId(DAO dao, Registro param) {
		 Registro ret = new Registro();
		try {
			ret.put("USER", new UsuarioDAO(dao).listarUsuario(param).get(0));
			ret.put("LISTA", new UsuarioDAO(dao).listarTipoPessoa(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro verificarLoginWeb(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new UsuarioDAO(dao).verificarLoginWeb(param);
			dao.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	private Registro verificarPessoa(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new UsuarioDAO(dao).verificarPessoa(param);
			dao.commit();
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
