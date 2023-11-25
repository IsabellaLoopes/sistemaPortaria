package com.portariaQrCode.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

@WebServlet(description = "QrCode", loadOnStartup = 5, urlPatterns = {"/vizualizar/qrCode"})
public class GenerateQrCode extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public GenerateQrCode() {
        super();
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String qrText = request.getParameter("qrText");
		//ByteArrayOutputStream out = QRCode.from(Criptografia.encripta(qrText)).to(ImageType.PNG).withSize(400,400).stream();
		ByteArrayOutputStream out = QRCode.from(Criptografia.encripta(qrText)).to(ImageType.PNG).withSize(400,400).stream();
		response.setContentType("image/png");
		response.setContentLength(out.size());
	     
		OutputStream os = response.getOutputStream();
	    os.write(out.toByteArray());
	    os.flush();
	    os.close();
	}
}