package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class AparelhoDAO {
	private DAO dao;
	
	public AparelhoDAO(DAO dao) {
		this.dao = dao;
	}
	
	public List<Registro> listarTipoOperacao(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarTipoOperacao @status=?", 
				new Object[] {param.getAsStringOrValue("status", "")});
	}
	
	public Registro salvarAparelho(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.salvarAparelho @id=?, @descricao=?, @tipoOperacao=?, @ip=?, @status=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("descricao"), param.getAsString("tipoOperacao"), 
						param.getAsString("ip"), param.getAsStringOrValue("status", "S")});
	}
	
	public List<Registro> listarAparelho(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarAparelho @status=?, @tipoOperacao=?, @id=?", 
				new Object[] {param.getAsStringOrValue("status", ""), param.getAsStringOrValue("tipoOperacao", ""),
						param.getAsIntOrZero("id")});
	}
	
	public Registro alteraStatusAparelho(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.alteraStatusAparelho @id=?, @status=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("status")});
	}
}
