package com.portariaQrCode.usuario;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

@WebServlet(description = "Usuario", loadOnStartup = 5, urlPatterns = {"/adm/usuario" })
public class UsuarioServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("adm/usuario") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			buscarDados(req, resp, HttpServices.HTTP_GET, "", "/WEB-INF/jsp/adm/usuario/usuario.jsp", "cabecalho");
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
			}			

			//JSONObject aux = new JSONObject(ret);
			//String dataRet = aux.getString("DATA");
			retorno.put("PARAMETROS", param);
			//retorno.put(Constantes.CODDER, aux.get(Constantes.CODDER));
			//retorno.put(Constantes.MSG, aux.get(Constantes.MSG));
			//retorno.put("DATA", new JSONObject(dataRet != null && !dataRet.isEmpty() ? dataRet.trim() : "{}"));

			//req.setAttribute("usuario", HttpServices.parseJSONListStringToHashMap(usuario));
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
	
	private Registro usuarioCabecalho(DAO dao, Registro param) {
		Registro ret = new Registro();
		try {
			ret.put("LISTA", new UsuarioDAO(dao).listarTipoPessoa(param));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

}
