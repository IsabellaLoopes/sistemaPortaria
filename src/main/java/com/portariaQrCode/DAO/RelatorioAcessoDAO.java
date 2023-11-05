package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class RelatorioAcessoDAO {
	private DAO dao;
	
	public RelatorioAcessoDAO(DAO dao) {
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
	
	public List<Registro> listarAcesso(Registro param) {
		System.out.println("hahaha");
		System.out.println(param);
		return dao.listaRowAsRegistro("EXEC historico.listarLogAcessoEntradaSaida @data=?, @aparelho=?, @pessoa=?, @tipoPessoa=?, @situacao=?", 
				new Object[] {param.getAsStringOrValue("data", ""), param.getAsIntOrZero("aparelho"), param.getAsIntOrZero("pessoa"), 
								param.getAsStringOrValue("tipoPessoa", ""), param.getAsIntOrValue("situacao", -2)});
	}
}
