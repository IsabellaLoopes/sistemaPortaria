package com.portariaQrCode.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.portariaQrCode.DAO.DAO;
import com.portariaQrCode.DAO.PessoaDAO;
import com.portariaQrCode.types.Registro;

@WebServlet(description = "Imagem", loadOnStartup = 5, urlPatterns = {"/vizualizar/imagem/*"})
public class Imagem extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public Imagem() {
        super();
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DAO dao = new DAO();
		Registro param = HttpServices.requestToRegistro(request);	
		
		try {
			dao.conecta();
			Registro pessoa = new PessoaDAO(dao).listarPessoa(param).get(0);
			byte[] imagem = null;
		    response.setContentType("image/jpeg"); 
		    OutputStream out = response.getOutputStream(); 

		    if(request.getRequestURI().indexOf("vizualizar/imagem/doc") > 0){
		    	imagem = pessoa.getAsByte("pes_documento");
		    } else if(request.getRequestURI().indexOf("vizualizar/imagem/foto") > 0) {
		    	imagem = pessoa.getAsByte("pes_foto");
		    }
		    out.write(imagem);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.desconecta();
		}	
	}
}