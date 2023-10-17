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

	public Registro salvarUsuario(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.salvarUsuario @id=?, @nome=?, @tipo=?, @email=?, @telParticular=?, @telCorporativo=?, @senha=?, @status=?, @cpf=?, @cnpj=?, @documento=?, @foto=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("nome"), param.getAsString("tipoPessoa"), 
						param.getAsString("email"), param.getAsString("telParticular"), param.getAsString("telCorporativo"), 
						param.getAsStringOrValue("senha", "senha"), param.getAsStringOrValue("status", "S"), param.getAsString("cpf"),
						param.getAsString("cnpj"), param.getAsString("documento"), param.getAsString("foto")});
	}
	
	public List<Registro> listarUsuario(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarUsuario @nome=?, @tipo=?, @status=?, @cpf=?, @id=?", 
				new Object[] {param.getAsStringOrValue("nome", ""), param.getAsStringOrValue("tipo", ""),
						param.getAsStringOrValue("status", ""), param.getAsStringOrValue("cpf", ""), 
						param.getAsIntOrZero("id")});
	}
	
	public Registro alteraStatusUsuario(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.alteraStatusUsuario @id=?, @status=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("status")});
	}
}
