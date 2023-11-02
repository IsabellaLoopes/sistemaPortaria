package com.portariaQrCode.perfil;

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
import com.portariaQrCode.DAO.PessoaDAO;
import com.portariaQrCode.DAO.UsuarioDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Perfil", loadOnStartup = 5, urlPatterns = {"/perfil/perfilCabecalho", "/perfil/perfilSalvar"})
public class PerfilServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("perfil/perfilCabecalho") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/perfil/pessoa.jsp", "");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getRequestURI().indexOf("perfil/perfilSalvar") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "", "salvar");
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
				retorno.put("DATA", pessoaIncluir(dao, param)); 
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
			}
			retorno.put("PARAMETROS", param);
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
			ret.put("LISTA", new PessoaDAO(dao).listarTipoPessoa(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro pessoaIncluir(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret.put("LISTA", new PessoaDAO(dao).listarTipoPessoa(param));
			ret.put("USUARIOS", new UsuarioDAO(dao).listarUsuario(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro usuarioSalvar(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret = new PessoaDAO(dao).salvarPessoa(param);
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
			ret = new PessoaDAO(dao).alteraStatusPessoa(param);
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
			ret = new PessoaDAO(dao).listarPessoa(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private Registro listarPorId(DAO dao, Registro param) {
		 Registro ret = new Registro();
		try {
			ret.put("PESSOA", new PessoaDAO(dao).listarPessoa(param).get(0));
			ret.put("LISTA", new PessoaDAO(dao).listarTipoPessoa(param));
			ret.put("USUARIOS", new UsuarioDAO(dao).listarUsuario(new Registro()));
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
