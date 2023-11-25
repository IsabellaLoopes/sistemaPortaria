package com.portariaQrCode.api.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.portariaQrCode.DAO.DAO;
import com.portariaQrCode.DAO.QrCodeDAO;
import com.portariaQrCode.DAO.UsuarioDAO;
import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.Criptografia;
import com.portariaQrCode.util.HttpServices;
import com.portariaQrCode.util.HttpUtil;

@WebServlet(description = "Leitura QR API", loadOnStartup = 5, urlPatterns = {"/api/leitura/qrCode"})
public class ApiLeituraQrServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().indexOf("api/leitura/qrCode") > 0) {
			req.setAttribute("data", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
			processarDados(req, resp, HttpServices.HTTP_POST, "leitura");
		}
	}

	private void processarDados(HttpServletRequest req, HttpServletResponse resp, String method, String banco) throws ServletException, IOException {
		DAO dao = new DAO();
		JSONObject retorno = new JSONObject();
		Registro param = HttpServices.requestToRegistro(req);	
		try {
			dao.conecta();
			if(banco.equals("leitura")) {
				retorno.put("DATA", leitura(dao, param)); 
			}
			dao.commit();
			retorno.put("PARAMETROS", param);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}
		
		resp.setContentType ("text/html;charset=utf-8");
		HttpUtil.flushJSON(resp.getOutputStream(), retorno.toString());
	}
	
	private Registro leitura(DAO dao, Registro param) {
		Registro ret = new Registro();
		ret.put("erro", -1);
		ret.put("mensagem", "Erro ao ler qrCode!");
		try {
			List<Registro> qrs = new QrCodeDAO(dao).listarQrCodesExistente();
			
			for(Registro qr : qrs) {
				System.out.println(param.getAsString("qrText"));
				System.out.println(Criptografia.encripta(qr.getAsString("qrCode")));
				System.out.println(qr.getAsString("qrCode"));
				System.out.println("----------------------------");
				if (Criptografia.encripta(qr.getAsString("qrCode")).equals(param.getAsString("qrText"))) {
					param.put("qrText", qr.getAsString("qrCode"));
					break;
				} /*else {
					param.put("qrText", "0/0");
				}*/
					
				
			}
			System.out.println(param);
			ret = new QrCodeDAO(dao).qrCode(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
}
