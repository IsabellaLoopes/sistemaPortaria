package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class PermissaoDAO {
	private DAO dao;
	
	public PermissaoDAO(DAO dao) {
		this.dao = dao;
	}

	public List<Registro> listarTipoPessoa(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarTipoPessoa @status=?", 
				new Object[] {param.getAsStringOrValue("status", "")});
	}
	
	public List<Registro> listarPessoa(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarPessoa @nome=?, @tipo=?, @status=?, @cpf=?, @id=?", 
				new Object[] {param.getAsStringOrValue("nome", ""), param.getAsStringOrValue("tipo", ""),
						param.getAsStringOrValue("status", ""), param.getAsStringOrValue("cpf", ""), 
						param.getAsIntOrZero("id")});
	}
	
	public List<Registro> listarAparelho(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarAparelho @status=?, @tipoOperacao=?, @id=?", 
				new Object[] {param.getAsStringOrValue("status", ""), param.getAsStringOrValue("tipoOperacao", ""),
						param.getAsIntOrZero("id")});
	}

	
	public Registro salvarPermissao(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.salvarPermissaoAparelho @id=?, @aparelho=?, @pessoa=?, @tipoPessoa=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsIntOrZero("aparelho"), param.getAsIntOrZero("pessoa"), 
						param.getAsString("tipoPessoa")});
	}
	
	public List<Registro> listarPermissao(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarPermissaoAparelho @id=?, @aparelho=?, @pessoa=?, @tipoPessoa=?", 
				new Object[] {param.getAsIntOrZero("id"), param.getAsIntOrZero("aparelho"), param.getAsIntOrZero("pessoa"), 
								param.getAsIntOrZero("tipoPessoa")});
	}
}
