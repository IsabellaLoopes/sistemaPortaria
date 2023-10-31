package com.portariaQrCode.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;

import com.portariaQrCode.DAO.DAO;
import com.portariaQrCode.types.Registro;

@WebServlet("/documentosUpload")
@MultipartConfig(maxFileSize = 2147483647) 
public class UploadDocumentos extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private File temp;
	private File tempD;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
		//UsuarioBean user = (UsuarioBean) request.getSession().getAttribute("usuario");	      
        InputStream streamFoto = null;
        InputStream streamDocumento = null;
        Registro param = HttpServices.requestToRegistro(request);
        Integer id = 0;
        
        Part documento = request.getPart("documento");
        Part foto = request.getPart("foto");
        
        response.setContentType("application/json");
        JSONObject obj = new JSONObject();
        PrintWriter outS = response.getWriter();
        obj.put("id", -1);
       
        System.out.println("foto");
        System.out.println(foto);
        System.out.println("doc");
        System.out.println(documento);
        if (foto != null && documento != null) {	                    	
        	temp = File.createTempFile("acessoSeguro-", ".tmp");
        	tempD = File.createTempFile("acessoSeguro-", ".tmp");
	             
            streamFoto = foto.getInputStream();
            OutputStream output = new FileOutputStream(temp);
            IOUtils.copy(streamFoto, output);
            streamFoto.close();
            output.close();
            FileInputStream fotoBanco = new FileInputStream(temp);
            
            streamDocumento = documento.getInputStream();
            OutputStream outputDocumento = new FileOutputStream(tempD);
            IOUtils.copy(streamDocumento, outputDocumento);
            streamDocumento.close();
            outputDocumento.close();
            FileInputStream documentoBanco = new FileInputStream(tempD);
            
            
			try {
				id = inserirDocumento(fotoBanco, documentoBanco, param.getAsInt("pessoa"));
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			fotoBanco.close();
        	temp.delete();
        	
        	documentoBanco.close();
        	tempD.delete();
        	
            obj.put("id", id);
            
	    } else if (documento != null) {	                    	
	    	tempD = File.createTempFile("acessoSeguro-", ".tmp");
	             
            streamDocumento = documento.getInputStream();
            OutputStream output = new FileOutputStream(tempD);
            IOUtils.copy(streamDocumento, output);
            streamDocumento.close();
            output.close();
            FileInputStream documentoBanco = new FileInputStream(tempD);
            
            
			try {
				id = inserirDocumento(null, documentoBanco, param.getAsInt("pessoa"));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			documentoBanco.close();
			tempD.delete();
            outS.print(obj);
            
	    } else if (foto != null) {	                    	
        	temp = File.createTempFile("acessoSeguro-", ".tmp");
	             
            streamFoto = foto.getInputStream();
            OutputStream output = new FileOutputStream(temp);
            IOUtils.copy(streamFoto, output);
            streamFoto.close();
            output.close();
            FileInputStream fotoBanco = new FileInputStream(temp);
            
            
			try {
				id = inserirDocumento(fotoBanco, null, param.getAsInt("pessoa"));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			fotoBanco.close();
        	temp.delete();
            obj.put("id", id);
	    }
        
        
        outS.print(obj);
	}
	
	private Integer inserirDocumento(FileInputStream documento, FileInputStream foto, Integer pessoa) throws SQLException {
		Connection con = null; // connection to the database
		PreparedStatement pstmt = null;
		StringBuffer sbQuery = new StringBuffer();
		int id = 0;
		try {
			
			DAO dao = new DAO();
			dao.conecta();
			con = dao.getCon();
			sbQuery.append("EXEC cadastro.atualizarDocumentosPessoa @documento=?, @foto=?, @pessoa=?");
		    pstmt = con.prepareStatement(sbQuery.toString());
			pstmt.setBinaryStream(1, documento); 
			pstmt.setBinaryStream(2, foto);
			pstmt.setInt(3, pessoa);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				id = rs.getInt("erro");
			}
			if(id == 0) {
				con.commit();
			}
	         
			pstmt.close();
			dao.desconecta();
		} catch (SQLException sex) {
			DAO.log("Erro [UploadDocumento.atualizarDocumentosPessoa()] >> " + sex + " << pstmt: " + pstmt.toString());
			throw sex;
		} catch (Exception ex) {
			DAO.log("Erro [UploadDocumento.atualizarDocumentosPessoa()] >> " + ex);
			throw ex;
		}
		return id;
	}
}
