package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class DashboardDAO {
	private DAO dao;
	
	public DashboardDAO(DAO dao) {
		this.dao = dao;
	}
	
	public List<Registro> listarDash(Registro param) {
		return dao.listaRowAsRegistro("EXEC historico.listarLogAcessoDash @data=?, @tipoOperacao=?", 
				new Object[] {param.getAsStringOrValue("data", ""), param.getAsStringOrValue("tipoOperacao", "")});
	}
}
