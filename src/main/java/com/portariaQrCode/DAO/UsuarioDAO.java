package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class UsuarioDAO {
	private DAO dao;
	
	public UsuarioDAO(DAO dao) {
		this.dao = dao;
	}

	public List<Registro> listarTipoPessoa(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarTipoPessoa @status=?", 
				new Object[] {param.getAsStringOrValue("status", "")});
	}

}
