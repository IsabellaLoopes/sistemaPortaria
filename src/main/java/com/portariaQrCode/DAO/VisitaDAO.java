package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class VisitaDAO {
	private DAO dao;
	
	public VisitaDAO(DAO dao) {
		this.dao = dao;
	}

	public List<Registro> listarTipoPessoa(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarTipoPessoa @status=?", 
				new Object[] {param.getAsStringOrValue("status", "")});
	}
	
	public Registro salvarVisita(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.salvarPermissaoAparelho @id=?, @aparelho=?, @pessoa=?, @tipoPessoa=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsIntOrZero("aparelho"), param.getAsIntOrZero("pessoa"), 
						param.getAsString("tipoPessoa")});
	}
	
	public List<Registro> listarVisita(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarVisita @data=?, @tipoPessoa=?", 
				new Object[] {param.getAsStringOrValue("data", ""), param.getAsStringOrValue("tipoPessoa", "")});
	}
}
