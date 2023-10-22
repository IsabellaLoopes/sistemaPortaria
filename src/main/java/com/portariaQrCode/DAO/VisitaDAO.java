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
		return dao.getRowAsRegistro("EXEC cadastro.salvarVisita @id=?, @cpf=?, @dataExpiracao=?, @responsavel=?, @observacao=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsStringOrValue("cpf", ""), param.getAsStringOrValue("dataExpiracao", ""), 
						param.getAsStringOrValue("responsavel", ""), param.getAsStringOrValue("observacao", "")});
	}
	
	public List<Registro> listarVisita(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarVisita @data=?, @tipoPessoa=?", 
				new Object[] {param.getAsStringOrValue("data", ""), param.getAsStringOrValue("tipoPessoa", "")});
	}
	
	public Registro salvarSaidaManual(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.salvarSaidaManual @id=?",
				new Object[] {param.getAsIntOrZero("id")});
	}
}
