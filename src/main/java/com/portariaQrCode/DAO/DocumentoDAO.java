package com.portariaQrCode.DAO;

import com.portariaQrCode.types.Registro;

public class DocumentoDAO {
	private DAO dao;
	
	public DocumentoDAO(DAO dao) {
		this.dao = dao;
	}
	
	public Registro atualizarDocumentosPessoa(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.atualizarDocumentosPessoa @documento=?, @foto=?, @pessoa=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("status")});
	}
}
