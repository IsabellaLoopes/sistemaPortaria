package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class PessoaDAO {
	private DAO dao;
	
	public PessoaDAO(DAO dao) {
		this.dao = dao;
	}

	public List<Registro> listarTipoPessoa(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarTipoPessoa @status=?", 
				new Object[] {param.getAsStringOrValue("status", "")});
	}

	public Registro salvarPessoa(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.salvarPessoa @id=?, @nome=?, @tipo=?, @email=?, @tel=?, @status=?, @cpf=?, @usr_id=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("nome"), param.getAsString("tipoPessoa"), 
						param.getAsString("email"), param.getAsString("tel"), param.getAsStringOrValue("status", "S"), param.getAsString("cpf"),
						param.getAsIntOrZero("usrId")});
	}
	
	public List<Registro> listarPessoa(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarPessoa @nome=?, @tipo=?, @status=?, @cpf=?, @id=?", 
				new Object[] {param.getAsStringOrValue("nome", ""), param.getAsStringOrValue("tipo", ""),
						param.getAsStringOrValue("status", ""), param.getAsStringOrValue("cpf", ""), 
						param.getAsIntOrZero("id")});
	}
	
	public Registro alteraStatusPessoa(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.alteraStatusPessoa @id=?, @status=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("status")});
	}
	
	public Registro salvarPerfil(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.salvarPerfil @id=?, @nome=?, @email=?, @tel=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("nome"), param.getAsString("email"), param.getAsString("tel")});
	}
}
